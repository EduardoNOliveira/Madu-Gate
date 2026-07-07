require("dotenv").config();

const { execSync } = require("child_process");

function runCommand(command) {
  console.log(`> ${command}`);
  execSync(command, { stdio: "inherit" });
}

function run() {
  runCommand("node scripts/runMigration.js");
  runCommand("node scripts/runMigration002.js");
  runCommand("node scripts/seedAdmin.js");
  console.log("Bootstrap concluido com sucesso.");
}

run();
