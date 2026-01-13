# Constant Perturbation Toolbox (MATLAB)
## Summary
This folder contains MATLAB utilities for implementing a constant perturbation into the Two-Body Problem. Equivalent to Solar Radiation Pressure.

## Functions


### posVel_0.m
**Description:** Computes the initial position and velocity vectors at time `t0` from a set of Keplerian orbital elements.

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `t_0` | Input time | s |
| `a` | Semi-major axis | km |
| `e` | Eccentricity | – |
| `i` | Inclination | deg |
| `ω` | Argument of periapsis | deg |
| `Ω` | Longitude of the ascending node | deg |
| `tp` | Time of periapsis passage | s |
| `mu` | Gravitational parameter | km³/s² |
| `tol` | Numerical tolerance for solving Kepler’s equation | – |

#### Outputs
| Variable | Description | Units |
|---------|-------------|-------|
| `r0_vec` | Initial position vector `[x, y, z]` | km |
| `v0_vec` | Initial velocity vector `[vx, vy, vz]` | km/s |

---

### two_body_equations_ctper.m
**Description:** Equations of motion for the 2-body problem with a constant force in the x
axis. The perturbation potential is
               R = g * dot( vec(r) , [1,0,0])
This function is intended for use inside numerical ODE integrators (e.g., `ode45`, `ode113`).

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `t` | Time | s |
| `X` | State vector `[x, y, z, vx, vy, vz]` | km, km/s |
| `mu` | Gravitational parameter | km³/s² |
| `g` | Constant acceleration magnitude in the +x direction | km/s² |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `dXdt` | Time derivative of the state vector `[vx, vy, vz, ax, ay, az]` | km/s, km/s² |

## Notes 

- All vectors are expressed in an inertial reference frame.
- Angles are assumed to be given in degrees.
- Position vectors are in kilometers (km) and velocity vectors in kilometers per second (km/s).
- Gravitational parameter `μ` must be provided in km³/s².
- Time is expressed in seconds.
- Functions based on Keplerian propagation are valid only for elliptic orbits (`e < 1`) unless otherwise stated.
- Special cases such as equatorial (`i = 0`) and circular (`e = 0`) orbits may require additional handling.

These implementations follow standard formulations used in astrodynamics literature.



## Vector Format Conventions

- All position and velocity vectors are assumed to be **row vectors** of the form  
  `[x, y, z]` and `[vx, vy, vz]`.

- Time arrays are assumed to be **1D arrays** of size `n × 1` or `1 × n`.

- Output arrays for time histories follow the convention:
  - Position history: `r_vec` → `n × 3` matrix  
  - Velocity history: `v_vec` → `n × 3` matrix  

  where each row corresponds to a time entry.
