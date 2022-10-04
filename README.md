<h1>Summary </h1>
This solution provide us the 3-tier application infrastructure. Here, App-service is restricted to be access from FrontDoor service which is enabled with OWASP3.0 WAF polices. It forwards the traffic to application load balancer (Private). I've prepared the terraform configuration files to deploy this through automation. Please refer to the below E-2-E flow.

![Diagram](https://user-images.githubusercontent.com/64698286/193441533-5f734369-0c7d-4151-88a9-ad2b5f764d32.jpg)

![image](https://user-images.githubusercontent.com/64698286/193752440-e84052a0-4733-47b8-935d-315f6c64db87.png)

![image](https://user-images.githubusercontent.com/64698286/193756285-5176bb98-cb42-4906-b05f-ba782fdf07b3.png)

![image](https://user-images.githubusercontent.com/64698286/193755925-b027ff30-a236-43e3-a774-f5cefc875967.png)

![image](https://user-images.githubusercontent.com/64698286/193756105-9d133eac-0ea1-4d33-8026-3b41b967879d.png)

![image](https://user-images.githubusercontent.com/64698286/193756371-755570be-8966-4281-995a-a2fbac9f411e.png)


