import pino from 'pino';

const logger = pino();

export default function Home() {
  logger.info('Hello, World!');
  return (
    <main className="">
      Hello, World!
    </main>
  )
}
