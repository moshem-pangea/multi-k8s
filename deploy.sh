docker build -t moshempangea/multi-client:latest -t moshempangea/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t moshempangea/multi-server:latest -t moshempangea/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t moshempangea/multi-worker:latest -t moshempangea/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push moshempangea/multi-client:latest
docker push moshempangea/multi-client:$SHA
docker push moshempangea/multi-server:latest
docker push moshempangea/multi-server:$SHA
docker push moshempangea/multi-worker:latest
docker push moshempangea/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=moshempangea/multi-server:$SHA
kubectl set image deployments/client-deployment client=moshempangea/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=moshempangea/multi-worker:$SHA