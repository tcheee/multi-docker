docker build -t tcheee42/multi-client:$SHA  -f ./client/Dockerfile ./client
# docker build -t tcheee42/multi-client:latest -f ./client/Dockerfile ./client
docker build -t tcheee42/multi-server:$SHA -f ./server/Dockerfile ./server
# docker build -t tcheee42/multi-server:latest -f ./server/Dockerfile ./server
docker build -t tcheee42/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# docker build -t tcheee42/multi-worker:latest -f ./worker/Dockerfile ./worker

# docker push tcheee42/multi-client:latest
# docker push tcheee42/multi-server:latest
# docker push tcheee42/multi-worker:latest
docker push tcheee42/multi-client:$SHA
docker push tcheee42/multi-server:$SHA
docker push tcheee42/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=tcheee42/multi-client:$SHA
kubectl set image deployments/server-deployment server=tcheee42/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tcheee42/multi-worker:$SHA