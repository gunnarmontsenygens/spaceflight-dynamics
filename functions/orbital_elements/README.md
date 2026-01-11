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


