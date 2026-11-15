// Writes a Markdown body holding one Mermaid flowchart.
// node gen-mermaid.mjs <edges> <target-chars> <title>
// The diagram is a binary tree with the given number of edges. When
// <target-chars> is above the natural size, `%%` comment lines pad the Mermaid
// source to exactly that many characters, so size and edge count vary apart.
const [edges, target, title] = [Number(process.argv[2]), Number(process.argv[3]), process.argv[4] ?? ""];
const lines = ["flowchart TD"];
for (let i = 1; i <= edges; i++) lines.push(`n${Math.floor((i - 1) / 2)} --> n${i}`);
let src = lines.join("\n");
if (target > src.length) {
  const room = target - src.length;
  // each pad line is "\n%% " + text; fill to the exact length
  let pad = "";
  while (pad.length < room) {
    const want = room - pad.length;
    if (want < 5) { pad += "\n%%" + "x".repeat(Math.max(0, want - 3)); break; }
    pad += "\n%% " + "x".repeat(Math.min(96, want - 4));
  }
  src += pad.slice(0, room);
}
const body = `${title}\n\n\`\`\`mermaid\n${src}\n\`\`\`\n`;
process.stdout.write(body);
process.stderr.write(`edges=${edges} mermaid_chars=${src.length} body_chars=${body.length}\n`);
