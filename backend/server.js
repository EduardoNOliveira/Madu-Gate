require("dotenv").config();

const app = require("./src/api/app");
const { testConnection } = require("./src/config/db");

const PORT = process.env.PORT || 3000;

async function bootstrap() {
  await testConnection();
  app.listen(PORT, () => {
    // Mantem o log minimalista para facilitar observabilidade local.
    console.log(`Madu Gate API online na porta ${PORT}`);
  });
}

bootstrap().catch((error) => {
  console.error("Falha ao inicializar API:", error);
  process.exit(1);
});
