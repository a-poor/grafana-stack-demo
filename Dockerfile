FROM node:20-bullseye

# Install pnpm...
RUN npm install -g pnpm

# Install Grafana's APT repo...
# RUN sudo mkdir -p /etc/apt/keyrings/ \
#   && wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null \
#   && echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list \
#   && sudo apt-get update \
#   && sudo apt-get install grafana-agent

# Install the app's dependancies...
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# ...and build the app
COPY . .
RUN pnpm run build

# Configure the app...
EXPOSE 80
ENV NODE_ENV=production
ENV PORT=80

# Run the app
CMD ["pnpm", "start"]
