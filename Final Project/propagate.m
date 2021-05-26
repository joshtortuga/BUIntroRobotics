function q_next = propagate(q,qd,dt)

q_next = q + qd*dt;   % Euler's method