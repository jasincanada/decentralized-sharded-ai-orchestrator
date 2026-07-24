# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial scaffolding and documentation
- Dynamic Nginx upstream management via `manage_endpoints.sh`
- Full Prometheus + Grafana observability stack
- Ubuntu 25 setup script with NVIDIA Container Toolkit
- Windows 11 + RTX 3070 Ti PowerShell setup
- Akash SDL deployment example for sharded vLLM
- Continue.dev integration guide

### Changed
- Enhanced routing logic in `simple-router.py` with 'balanced' strategy support

### Fixed
- Bug in argument parser for `--best-for balanced` called from manage_endpoints.sh
- Typo in print statement in router main function

### Deprecated
- N/A

### Removed
- N/A

### Security
- N/A

## [0.1.0] - 2026-07-15

### Added
- First public release of decentralized-sharded-ai-orchestrator
- Core orchestration: Nginx reverse proxy with least_conn load balancing
- Endpoint management system (`endpoints/endpoints.txt` + `manage_endpoints.sh`)
- Production-grade monitoring (Prometheus job + Grafana dashboard focused on vLLM metrics)
- One-command Ubuntu server bootstrap
- Windows 11 Docker Desktop support for consumer GPUs
- Decentralized deployment template (Akash)
- Complete repository structure and documentation

### Notes
This is the foundational release focused on making heterogeneous GPU nodes (local + decentralized) work together reliably with minimal operational overhead.