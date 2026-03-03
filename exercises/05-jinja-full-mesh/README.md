# Exercise 5 – Full-Mesh Jinja Challenge

## Objective
Create a scalable full-mesh topology in Containerlab using Jinja2.

## Input Variables
```yaml
seed_name: topo-mesh
instance_id: 3
node_count: 4
node_image: alpine:latest
```
Optional:
```yaml
mgmt_network: stuttgart
```

## Requirements
- Nodes must be named `r1`..`rN`
- Management IPs must follow: `99.1.<instance_id>.<10 + node_number>`
- Full mesh: every node connects to every other node exactly once
- Links must avoid duplicates
- Interface numbers must increment per node

### Interface numbering rule
For 4 nodes, the links should look like this:
```
r1:eth1 — r2:eth1
r1:eth2 — r3:eth1
r1:eth3 — r4:eth1
r2:eth2 — r3:eth2
r2:eth3 — r4:eth2
r3:eth3 — r4:eth3
```
Each node increments eth index as new links are added.

## Starter Files
- `starter/topo-mesh.BROKEN.clab.yaml.j2` (intentionally broken)
- `values.yaml` (example input)

## Tasks
1. Fix the starter template to satisfy all requirements.
2. Render the template using `values.yaml` (or your own data).
3. Deploy the rendered topology and verify it works.

## Success Criteria
- No duplicate links
- Correct management IPs
- Correct interface numbering
- Works for `node_count` 3–10

## Optional Stretch
- Add `loopback: true` to create `lo0: 10.<instance_id>.<node>.1/32`
- Support `topology_type: full-mesh | ring` in the same template
