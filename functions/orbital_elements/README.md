# Orbital Elements & Orbit Determination Toolbox (MATLAB)
## Summary
This folder contains MATLAB utilities for working with Keplerian orbital elements and
supporting orbit determination workflows. The toolbox includes element/state conversions,
orbit geometry vectors, and codes to determine positions and velocities at different times.

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

### true_anomaly.m
**Description:** Computes the true anomaly \( f(t) \) at a given time for an elliptic orbit (\( e < 1 \)).

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `t` | Input time | s |
| `r0_vec` | Position vector at time `t = t0` (`[x, y, z]`) | km |
| `v0_vec` | Velocity vector at time `t = t0` (`[vx, vy, vz]`) | km/s |
| `t0` | Initial time | s |
| `mu` | Gravitational parameter | km³/s² |
| `tol` | Numerical tolerance for solving Kepler’s equation | – |

#### Output
| Variable | Description | Units |
|---------|-------------|-------|
| `f` | True anomaly | deg |

---

### orbital_elements.m
**Description:** Computes the Keplerian orbital elements from an inertial position and velocity state.  
Equatorial and circular orbits may require special handling.

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `r0_vec` | Position vector at time `t = t0` (`[x, y, z]`) | km |
| `v0_vec` | Velocity vector at time `t = t0` (`[vx, vy, vz]`) | km/s |
| `t0` | Initial time | s |
| `mu` | Gravitational parameter | km³/s² |

#### Outputs
| Variable | Description | Units |
|---------|-------------|-------|
| `a` | Semi-major axis | km |
| `e` | Eccentricity | – |
| `i` | Inclination | deg |
| `ω` | Argument of periapsis | deg |
| `Ω` | Longitude of the ascending node | deg |
| `tp` | Time of periapsis passage | s |

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

### posVel.m
**Description:** Computes the position and velocity vectors at a given time for an elliptic orbit (\( e < 1 \)) using Keplerian propagation.

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `t` | Input time | s |
| `r0_vec` | Position vector at time `t = t0` (`[x, y, z]`) | km |
| `v0_vec` | Velocity vector at time `t = t0` (`[vx, vy, vz]`) | km/s |
| `t0` | Initial time | s |
| `mu` | Gravitational parameter | km³/s² |
| `tol` | Numerical tolerance for solving Kepler’s equation | – |

#### Outputs
| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec` | Position vector at time `t` (`[x, y, z]`) | km |
| `v_vec` | Velocity vector at time `t` (`[vx, vy, vz]`) | km/s |

---

### posVelArray.m
**Description:** Computes the position and velocity vectors at multiple times for an elliptic orbit (\( e < 1 \)) using Keplerian propagation.

#### Inputs
| Variable | Description | Units |
|---------|-------------|-------|
| `t_array` | Array of input times | s |
| `r0_vec` | Position vector at time `t = t0` (`[x, y, z]`) | km |
| `v0_vec` | Velocity vector at time `t = t0` (`[vx, vy, vz]`) | km/s |
| `t0` | Initial time | s |
| `mu` | Gravitational parameter | km³/s² |
| `tol` | Numerical tolerance for solving Kepler’s equation | – |

#### Outputs
| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec` | Position vectors at times `t_array` (`n × 3`) | km |
| `v_vec` | Velocity vectors at times `t_array` (`n × 3`) | km/s |


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
