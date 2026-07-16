# Basic Sharding Strategy Design (Task #9)

**Date**: 2026-07-16
**Status**: Design Complete
**Related Tasks**: #8, #9

## Goal
Enable running large/frontier models by distributing them across multiple nodes using tensor parallelism and intelligent placement.

## Current Foundation
The system already supports multiple nodes via Nginx least_conn. This gives us a good base for sharding.

## Proposed Approach

### Simple Sharding (Initial)
- Use vLLM's built-in `--tensor-parallel-size` on capable nodes.
- For very large models, manually assign different tensor-parallel groups to different backends.
- Use metadata in `endpoints.txt` to indicate node capabilities (e.g., number of GPUs, VRAM).

### More Advanced (Future)
- A routing layer (from Task #8) that can:
  - Detect model size requirements
  - Automatically select or combine nodes that can host the required tensor-parallel size
  - Fall back to smaller quantized versions if full sharding isn't available

### Practical Starting Point
1. Document node capabilities in `endpoints.txt` comments.
2. Provide examples in documentation for running large models with tensor-parallel across 2+ nodes.
3. Keep the core orchestrator simple — sharding decisions can start manual or semi-automated.

## Decision
Focus on documentation and metadata first. Full automated sharding logic will come after we have real multi-node + multi-provider setups.

This aligns with the gradual, smallest-viable philosophy.