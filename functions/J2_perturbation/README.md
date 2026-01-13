# J2 Perturbation Toolbox (MATLAB)
## Summary
This folder contains MATLAB utilities for implementing the J2 perturbation into the Two-Body Problem.

## Functions

### e_vec_hat.m
**Description:** Calculates normalized eccentricity vector.
#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `i` | Inclination | deg |
| `ω` | Argument of periapsis | deg |
| `Ω` | Longitude of the ascending node | deg |

#### Output
| Variable | Description | Units |
|---------|-------------|-------|
| `e_hat` | Normalized eccentricity vector | – |

---

### e_hat_perp.m
**Description:** Calculates the normalized vector perpendicular to the eccentricity vector.

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `i` | Inclination | deg |
| `ω` | Argument of periapsis | deg |
| `Ω` | Longitude of the ascending node | deg |

#### Output
| Variable | Description | Units |
|---------|-------------|-------|
| `e_hat_perp` | Normalized vector perpendicular to the eccentricity vector | – |

---

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


### twobp_solver_file.m
**Description:** Solves the two-body problem by numerically propagating an initial Cartesian state from `t0` to `tf` and saving the solution to a text file.

The propagated state history is written to a `.txt` file with tab-separated columns containing time, position, and velocity.

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `r0_vec` | Position vector at time `t = t0` (`[x, y, z]`) | km |
| `v0_vec` | Velocity vector at time `t = t0` (`[vx, vy, vz]`) | km/s |
| `mu` | Gravitational parameter | km³/s² |
| `t0` | Initial time | s |
| `tf` | Final time | s |

#### Output
| Variable | Description | Units |
|---------|-------------|-------|
| `dfile` | Name of the output text file containing the propagated solution | – |

#### Output file contents (`twobp_solutions.txt`)
The generated file contains the following tab-separated columns:

| Column | Description | Units |
|--------|-------------|-------|
| `t` | Time array | s |
| `x, y, z` | Position components | km |
| `vx, vy, vz` | Velocity components | km/s |

---

### `twobp_solver_J2.m`
**Description:** Numerically propagates a Cartesian two-body state from `t0` to `tf` including the **J2 oblateness perturbation**, returning the full state history.

This function integrates the equations of motion with a central gravity term (`mu`) plus the J2 acceleration term defined by the body radius `R_0` and the coefficient `J_2`.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `r0_vec` | Position vector at time `t = t0` (`[x, y, z]`) | km |
| `v0_vec` | Velocity vector at time `t = t0` (`[vx, vy, vz]`) | km/s |
| `mu` | Gravitational parameter | km³/s² |
| `R_0` | Central body equatorial radius | km |
| `J_2` | J2 oblateness coefficient | – |
| `t0` | Initial time | s |
| `tf` | Final time | s |

#### Outputs

| Variable | Description | Units |
|---------|-------------|-------|
| `rt_vec` | Position history array (`N × 3`, columns are `[x, y, z]`) | km |
| `vt_vec` | Velocity history array (`N × 3`, columns are `[vx, vy, vz]`) | km/s |
| `t` | Time array (`N × 1`) | s |

---

#### Notes
- Assumes a fixed central body with J2 perturbation (no drag, SRP, third-body, etc.).
- Input units must be consistent (recommended: km, s, km/s, km³/s²).
- The state history length `N` depends on the numerical integrator settings (step size / tolerances).

---











### two_body_equations.m
**Description:** Implements the equations of motion for the classical two-body problem under a central gravitational field.

This function propagates a point mass under Newtonian gravity, assuming a spherically
symmetric central body and no perturbations. The state vector is expressed in inertial
Cartesian coordinates.
    
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

### twobp_solver.m
**Description:** Solves the two-body problem by propagating an initial Cartesian state from `t0` to `tf`.

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `r0_vec` | Position vector at time `t = t0` (`[x, y, z]`) | km |
| `v0_vec` | Velocity vector at time `t = t0` (`[vx, vy, vz]`) | km/s |
| `mu` | Gravitational parameter | km³/s² |
| `t0` | Initial time | s |
| `tf` | Final time | s |

#### Outputs
| Variable | Description | Units |
|---------|-------------|-------|
| `rt_vec` | Position history at times `t` (`N × 3`) | km |
| `vt_vec` | Velocity history at times `t` (`N × 3`) | km/s |
| `t` | Time array | s |

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
