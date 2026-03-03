# Containerlab Variables and Jinja Lab

Learn Containerlab by doing. This repo is a 1-2 hour lab exercise where every participant builds and runs their own labs while practicing:
- Variables for reusable topology inputs
- Jinja templates for scalable topology generation
- DRY (Don't Repeat Yourself) design in infra-as-code workflows

## Session Outcomes
By the end of the session, participants should be able to:
1. Deploy, inspect, and destroy labs confidently.
2. Parameterize topologies with environment variables.
3. Render Jinja templates into valid Containerlab topologies.
4. Avoid copy/paste topology design by applying DRY.

## Prerequisites
- Containerlab installed (`clab` or `containerlab`)
- Docker or Podman running locally
- Access to required images:
  - `alpine:latest`
  - `ghcr.io/srl-labs/network-multitool:latest`
  - `ghcr.io/nokia/srlinux:latest` (Exercise 3)
- Optional: VS Code + Containerlab extension

## Run In GitHub Codespaces
This repository includes `.devcontainer/` so exercises can run in Codespaces with Docker, Containerlab, and Jinja tools preinstalled.

Codespaces demo video: [Watch the demo](https://github.com/user-attachments/assets/3afe409e-19d4-4c02-a227-750fa296ed78)

1. Open the repository in GitHub Codespaces.
2. Wait for post-create setup to complete.
3. If Docker is not ready, run:
```bash
bash .devcontainer/scripts/start-docker.sh
```
4. Verify tools:
```bash
containerlab version
docker version
jinja2 --version
```

## Suggested Timeline (90-120 min)
1. Exercise 1 - 10 to 15 min
2. Exercise 2 - 15 to 20 min
3. Exercise 3 - 15 to 20 min
4. Exercise 4 - 15 to 20 min
5. Exercise 5 - 20 to 30 min

## Quick Command Reference
If `clab` alias exists:
```bash
clab deploy -t <topo-file>
clab inspect -t <topo-file>
clab destroy -t <topo-file>
```
If not, replace `clab` with `containerlab`.

## Repository Structure
- `exercises/01-basic-lab/` basic two-node Linux lab
- `exercises/02-variables/` env variable driven topology
- `exercises/03-vscode-bulk-links/` VS Code bulk link workflow
- `exercises/04-jinja-template/` template + data + rendered example
- `exercises/05-jinja-full-mesh/` starter/solution challenge for scalable full-mesh generation

## Exercise Walkthrough

### Exercise 1 - Basic Deploy/Inspect/Destroy
File: `exercises/01-basic-lab/topo01.clab.yaml`

Goal:
Deploy a minimal lab, inspect it, and clean it up.

Steps:
1. Deploy.
```bash
clab deploy -t exercises/01-basic-lab/topo01.clab.yaml
```
2. Inspect to get management IPs.
```bash
clab inspect -t exercises/01-basic-lab/topo01.clab.yaml
```
3. Destroy.
```bash
clab destroy -t exercises/01-basic-lab/topo01.clab.yaml
```

### Exercise 2 - Variables and Reuse
File: `exercises/02-variables/topo02.clab.yaml`

Goal:
Use `INSTANCE_ID` to drive management subnet and node IP addressing without hardcoding.

Steps:
1. Deploy with variable.
```bash
INSTANCE_ID=10 clab deploy -t exercises/02-variables/topo02.clab.yaml
```
2. Change `INSTANCE_ID` and redeploy to observe management subnet/IP changes.
3. Add `r3` using the same variable pattern and link it to the topology.
4. Destroy when done.
```bash
clab destroy -t exercises/02-variables/topo02.clab.yaml
```

Note:
`INSTANCE_ID` in this exercise controls IP addressing only. The lab name is static.

### Exercise 3 - Bulk Links with VS Code
File: `exercises/03-vscode-bulk-links/topo03.clab.yaml`

Goal:
Use the Containerlab VS Code extension to generate/maintain links faster.

Steps:
1. Open the topology in VS Code.
2. Rebuild links via bulk link editor from `srl1` to `client1..client4`.
3. Deploy and validate.
```bash
clab deploy -t exercises/03-vscode-bulk-links/topo03.clab.yaml
```
4. Destroy.
```bash
clab destroy -t exercises/03-vscode-bulk-links/topo03.clab.yaml
```

### Exercise 4 - Jinja Templating Basics
Files:
- `exercises/04-jinja-template/template.clab.yaml.j2`
- `exercises/04-jinja-template/values.yaml`
- `exercises/04-jinja-template/topo04.clab.yaml` (reference render)

Goal:
Render a topology from variables and scale node count by changing data, not topology logic.

Steps:
1. Open the online Jinja renderer: https://nebula.packetcoders.io/j2-render/
2. Paste `template.clab.yaml.j2` as template input and `values.yaml` as data input.
3. Render, then compare the output with `topo04.clab.yaml`.
4. Change `instance_id` and `node_count`, render again, then deploy.

Corner case note:
- Jinja generation can still produce invalid topology edge cases.
- In this exercise, the ring template can render duplicate endpoints (`rX:eth1` reused), which causes deploy failure such as:
  `ERROR Duplicate endpoint r1:eth1 ...`
- Depending on impact, manual correction of the rendered topology is acceptable.
- Practical manual fix approach: keep the ring order but increment interface indexes so each node uses unique interfaces (for example `eth1` and `eth2` in a 4-node ring).

### Exercise 5 - Full-Mesh DRY Challenge
Files:
- `exercises/05-jinja-full-mesh/README.md`
- `exercises/05-jinja-full-mesh/starter/topo-mesh.BROKEN.clab.yaml.j2`
- `exercises/05-jinja-full-mesh/values.yaml`
- `exercises/05-jinja-full-mesh/solution/topo-mesh.clab.yaml.j2` (facilitator use)

Goal:
Implement full-mesh link generation with correct per-node interface indexing and no duplicate links.

Steps:
1. Start from the broken starter template.
2. Fix mgmt IP math, duplicate links, and interface numbering.
3. Use https://nebula.packetcoders.io/j2-render/ to render the template repeatedly with different `node_count` values (3 to 10), then deploy the rendered topology.

## Facilitator Notes
- Keep participants in build-validate-destroy loops after every exercise.
- Pre-pull images to reduce waiting time.
- Hide `exercises/05-jinja-full-mesh/solution/` during the challenge.
