const fastify = require('fastify')({ logger: true });

const cors = require('@fastify/cors');

const PORT = 3000;

// CORS enabled
fastify.register(cors, {
  origin: "*"
});

// Endpoint che accetta 3 parametri come input
fastify.get('/api/data', (request, reply) => {
    const param1 = request.query.param1;
    const param2 = request.query.param2;
    const param3 = request.query.param3;

    // Controllo che i parametri siano forniti
    if (!param1 || !param2 || !param3) {
        reply.code(400).send({ error: 'Per favore, fornisci tutti e tre i parametri.' });
        return;
    }

    // Qui puoi elaborare i dati come preferisci
    const responseData = {
        receivedParam1: param1,
        receivedParam2: param2,
        receivedParam3: param3
    };
    console.log("Ma quanto ce vò???")
    setTimeout(function() {
        reply.send(responseData);
    }, 5000);
});

fastify.listen(PORT, '0.0.0.0', (err, address) => {
    if (err) {
        fastify.log.error(err);
        process.exit(1);
    }
    fastify.log.info(`Server in ascolto alla porta ${address}`);
});
