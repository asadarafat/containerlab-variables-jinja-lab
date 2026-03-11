# Exercise 6 – Existing Bridge Rescue Challenge

## Objective
Adapt the exercise 2 variable pattern so the lab reuses an already existing OOB bridge instead of creating a fresh management network.

## Input Variables
```bash
SUBNET_ID=7
```

## Local Bridge Assumption
The challenge assumes this bridge already exists on the host:

```text
br_nsp_ip_oob  10.2.7.2/24
```

This exercise is intended for a local host and is not expected to work unchanged in GitHub Codespaces.

## Requirements
- Lab name must be `topo${SUBNET_ID}`
- Management bridge must be `br_nsp_ip_oob`
- Management subnet must be `10.2.${SUBNET_ID}.0/24`
- Management gateway must be `10.2.${SUBNET_ID}.2`
- Node names must stay `r1` and `r2`
- Management IPs must follow `10.2.${SUBNET_ID}.11` and `10.2.${SUBNET_ID}.12`
- The lab must keep the `r1` to `r2` data link
- The topology must deploy without conflicting with the bridge gateway IP

## Starter Files
- `starter/topo06.BROKEN.clab.yaml` (intentionally broken)
- `topo06.clab.yaml` (reference solution for facilitators)

## Tasks
1. Fix the starter topology so it satisfies all requirements.
2. Deploy it with `SUBNET_ID=7`.
3. Inspect the lab and confirm the management addresses are correct.
4. Verify reachability to `10.2.7.2` from `r1`.

## Success Criteria
- The lab uses the existing `br_nsp_ip_oob` bridge
- The subnet and gateway match the chosen `SUBNET_ID`
- Node IPs land on `.11` and `.12`
- The topology is still variable-driven like exercise 2

## Optional Stretch
- Add `r3` with `10.2.${SUBNET_ID}.13`
- Change `SUBNET_ID` and explain what must already exist on the host for the topology to keep working
