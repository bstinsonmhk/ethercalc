FROM node:4.8

RUN npm install -g ethercalc pm2 || true
RUN rm -rf /usr/local/lib/node_modules/ethercalc/node_modules/nodemailer/ || true

RUN mkdir /data
RUN chgrp -R 0 /data && chmod -R g+rwX /data
USER 1001
EXPOSE 8000
CMD ["sh", "-c", "REDIS_HOST=$REDIS_PORT_6379_TCP_ADDR REDIS_PORT=$REDIS_PORT_6379_TCP_PORT pm2 start -x `which ethercalc` -- --cors && pm2 logs"]
