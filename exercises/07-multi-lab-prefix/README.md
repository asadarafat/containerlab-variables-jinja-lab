# Exercise 7 – Multi-Lab Prefix Challenge

## Objective
Reuse a single Containerlab topology file to deploy multiple labs on the same existing OOB bridge by varying the lab name with a prefix.

## Input Variables
```bash
SUBNET_ID=7
```

Optional:
```bash
PREFIX=-01
PREFIX=-02
```

## Local Bridge Assumption
The challenge assumes this bridge already exists on the host:

```text
br_nsp_ip_oob  10.2.7.2/24
```

This exercise is intended for a local host and is not expected to work unchanged in GitHub Codespaces.

## Requirements
- The topology name must support an empty prefix and prefixed variants such as `-01` and `-02`
- The topology must use the existing `br_nsp_ip_oob` management bridge
- The management subnet must remain `10.2.${SUBNET_ID}.0/24`
- The management gateway must remain `10.2.${SUBNET_ID}.2`
- The same topology file must be reusable for multiple lab deployments
- The chosen management IP last octets must not overlap with other active Containerlab topologies on the same bridge

## Starter Files
- `starter/topo07.BROKEN.clab.yaml` (intentionally broken)
- `topo07.clab.yaml` (reference solution for facilitators)

## Tasks
1. Fix the starter topology so the lab name changes with `PREFIX`.
2. Keep the topology on the existing `br_nsp_ip_oob` bridge.
3. Choose management IP last octets that do not collide with other labs on the same subnet.
4. Deploy with no prefix, then with `PREFIX=-01`, then with `PREFIX=-02`.
5. Destroy the prefixed labs when done.

## Success Criteria
- `SUBNET_ID=7 clab deploy -t topo07.clab.yaml` produces a base lab name without collisions
- `PREFIX=-01` and `PREFIX=-02` produce distinct lab names from the same file
- The topology still lands on the existing OOB bridge
- The operator understands that unique management IP last octets are still required across concurrent labs

## Optional Stretch
- Parameterize the host octets too, so the topology can avoid IP overlap without manual file edits
- Add `r3` with another non-overlapping management IP on the same subnet
