# Orbital Elements & Orbit Determination Toolbox (MATLAB)
## Summary
This folder contains MATLAB utilities for working with Keplerian orbital elements and
supporting orbit determination workflows. The toolbox includes element/state conversions,
orbit geometry vectors, and codes to determine positions and velocities at different times.

## Functions
### 'e_vec_hat.m'
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
