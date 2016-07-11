* MOS subcircuits with parasitics evaluation for 0.35u/3.3V 

* NMOS
.subckt submodn drain gate source bulk param: w l m=1
m0 (drain gate source bulk) modn w={w} l={l} m={m} ad={w*0.85u} as={w*0.85u} pd={1.7u + w } ps={(w+1.7u)} nrs={0.3u/w} nrd={0.3u/w}
.ends

* PMOS
.subckt submodp drain gate source bulk param: w l m=1
m0 (drain gate source bulk) modp w={w} l={l} m={m} ad={w*0.85u} as={w*0.85u} pd={1.7u +w} ps={1.7u + w} nrs={0.3u/w} nrd={0.3u/w}
.ends
