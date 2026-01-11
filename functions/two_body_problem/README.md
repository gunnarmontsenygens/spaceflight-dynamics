# Two-Body Problem Toolbox (MATLAB)
## Summary
This folder contains MATLAB utilities for solving the two-body problem numerically.

## Functions
### two_body_equations.m
**Description:** Implements the equations of motion for the classical two-body problem under a central gravitational field.

This function propagates a point mass under Newtonian gravity, assuming a spherically
symmetric central body and no perturbations. The state vector is expressed in inertial
Cartesian coordinates and follows

\[
\ddot{\mathbf{r}} = -\mu \frac{\mathbf{r}}{r^3}
\]

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `t` | Time | s |
| `X` | State vector `[x, y, z, vx, vy, vz]` | km, km/s |
| `mu` | Gravitational parameter | km³/s² |

#### Output
| Variable | Description | Units |
|---------|-------------|-------|
| `dXdt` | Time derivative of the state vector `[vx, vy, vz, ax, ay, az]` | km/s, km/s² |

---




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
