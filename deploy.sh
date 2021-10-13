# Build images
docker build -t vianabcc/multi-client:latest -f vianabcc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vianabcc/multi-server:latest -f vianabcc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vianabcc/multi-worker:latest -f vianabcc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push images to Dockerhub
docker push vianabcc/multi-client:latest 
docker push vianabcc/multi-server:latest 
docker push vianabcc/multi-worker:latest
docker push vianabcc/multi-client:$SHA  
docker push vianabcc/multi-server:$SHA  
docker push vianabcc/multi-worker:$SHA  

# Apply Kubernets config
kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=vianabcc/multi-client:$SHA
kubectl set image deployments/server-deployment server=vianabcc/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=vianabcc/multi-worker:$SHA
