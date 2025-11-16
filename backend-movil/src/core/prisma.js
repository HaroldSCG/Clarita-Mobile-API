// backend-movil/src/core/prisma.js
import { PrismaClient } from '@prisma/client';
import env from './env.js';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: env.DATABASE_URL,
    },
  },
  log: ['error', 'warn'],
});

export default prisma;
