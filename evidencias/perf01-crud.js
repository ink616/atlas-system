// CP-PERF-01: p95 < 300 ms en CRUD simple bajo carga normal (10 VUs, 1 min)
import http from 'k6/http';
import { check, sleep } from 'k6';
export const options = {
  vus: 10, duration: '1m',
  thresholds: { 'http_req_duration{op:crud}': ['p(95)<300'], http_req_failed: ['rate<0.01'] },
};
const API = 'http://localhost:5000';
export function setup() {
  const r = http.post(`${API}/api/auth/login`, JSON.stringify({ email: 'admin@atlas.cl', password: 'Password123!' }), { headers: { 'Content-Type': 'application/json' } });
  return { token: r.json('token') };
}
export default function (d) {
  const h = { headers: { Authorization: `Bearer ${d.token}`, 'Content-Type': 'application/json' }, tags: { op: 'crud' } };
  const l = http.get(`${API}/api/clientes`, h);
  check(l, { 'GET clientes 200': (r) => r.status === 200 });
  const c = http.post(`${API}/api/clientes`, JSON.stringify({ rut: '12.345.678-5', razon_social: `Carga PERF-01 ${__VU}-${__ITER}` }), h);
  check(c, { 'POST cliente 201': (r) => r.status === 201 });
  sleep(1);
}
