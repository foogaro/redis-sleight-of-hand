const fastify = require('fastify')({ logger: true });

const cors = require('@fastify/cors');

const PORT = 3000;

// CORS enabled
fastify.register(cors, {
  origin: "*"
});

// Endpoint that accepts 3 parameters as input
fastify.get('/api/data', (request, reply) => {
    const param1 = request.query.param1;
    const param2 = request.query.param2;
    const param3 = request.query.param3;

    // Check if the parameters are provided
    if (!param1 || !param2 || !param3) {
        reply.code(400).send({ error: 'Please provide all three parameters.' });
        return;
    }

    // Here you can process the data as you prefer
    const responseData = {
        receivedParam1: param1,
        receivedParam2: param2,
        receivedParam3: param3
    };
    console.log("Processing request...")
    setTimeout(function() {
        reply.send(responseData);
    }, 5000);
});

fastify.listen(PORT, '0.0.0.0', (err, address) => {
    if (err) {
        fastify.log.error(err);
        process.exit(1);
    }
    fastify.log.info(`Server listening on port ${address}`);
});
