# Tooling & MCP

Use this category for the tooling an agent actually operates: MCP servers that expose a disassembler or decompiler, verification helpers that independently re-check what an agent produced, and collaboration layers that split work between agents. The entry should say what the tool exposes to the model and, where it applies, what it checks.

What does not belong here: the decompilation or port projects themselves (see the two categories above), and general-purpose agent frameworks with no reverse-engineering surface.

- [ida-mcp](https://github.com/HexRaysSA/ida-mcp) - Tooling: Hex-Rays' official MCP server for IDA; the 500-billion-token decompilation ran on it for almost the whole project and credits it as stable and headless, which is the practical bar for tooling in this loop.
- [ida-pro-mcp](https://github.com/mrexodia/ida-pro-mcp) - Tooling: an MCP server that gives an agent disassembly and decompilation from IDA Pro, the most widely used entry point for agent-driven reversing.
- [decomp-compat-kit](https://github.com/LinuxJessi/decomp-compat-kit) - Verification tooling: independent byte verification for matching decompilations, so the check runs outside the build the agents just produced.
