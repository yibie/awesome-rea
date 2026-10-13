# Static Recompilation & Native Ports

Use this category for projects that turn a released binary into a program that runs natively on another platform — static recompilation, or a port built on top of a matching decompilation. These rarely promise byte-exactness; what they promise instead is that the game is playable and does not behave differently. So the acceptance test is what the entry has to name: a comparison against the original ROM, a required hash match on the user's own dump, a compatibility matrix, or frame-time measurements.

What does not belong here: projects whose counter is byte-exact function matching (see Game Decompilation), and emulators, which do not reimplement the game at all.

- [goldeneye-pc-port](https://github.com/jkdansereau/goldeneye-pc-port) - Native port: two coding agents ported a matching decompilation of GoldenEye 007 to PC in 43 days, verified by byte comparison against the original ROM plus a porting-notes log that requires every recurring bug class to be written back before it is considered closed.
- [BattleShip](https://github.com/vinvirile/BattleShip) - Native port: a Super Smash Bros. port its author describes as 100% AI-generated over 25 days with Opus 4.6/4.7 and GPT 5.5, verified by requiring the user's own ROM dump to match a known hash, and shipping no Nintendo assets at all.
- [ssbu-recomp](https://github.com/Denkishi/ssbu-recomp) - Static recompilation: Super Smash Bros. Ultimate 13.0.4 rebuilt as a native Windows program with Vulkan rendering, verified by a per-mode compatibility matrix that marks modes "works", "tested with scripted input only" or "not tested", plus frame-time measurements including a whole match at 59-60 fps on an integrated GPU.
- [VandalHearts-decomp](https://github.com/HalmyLyseas/VandalHearts-decomp-SLPM-86007) - Native port: Vandal Hearts rebuilt for PC on top of a byte-exact matching decompilation, so the port inherits the decompilation's byte comparison as its correctness check.
