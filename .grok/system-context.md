# System Context for decentralized-sharded-ai-orchestrator

This repository builds a production-oriented orchestration layer for sharded vLLM inference.

**Current State (v0.1.0):**
- Dynamic Nginx reverse proxy with least_conn load balancing driven by endpoints/endpoints.txt
- One-command Ubuntu setup with Docker + NVIDIA toolkit
- Windows 11 + RTX 3070 Ti support via Docker Desktop
- Akash deployment example
- Prometheus + Grafana observability focused on vLLM metrics
- Designed for personal AI sovereignty and heterogeneous nodes (local + decentralized)

**Intended Evolution:**
- Become a durable, stage-gated engineering platform itself via this workflow scaffold.
- Support additional decentralized providers (AIOZ, Dynex, and similar GPU/inference networks).
- Enable sharding strategies for accessing frontier models across mixed hardware.
- Maintain strong emphasis on observability, fault tolerance, minimal operational complexity, and interface stability.

**Grok's Role:**
Act as an agentic engineer that follows the 8-stage workflow, uses markdown artifacts for memory, and makes the smallest viable, well-documented changes.