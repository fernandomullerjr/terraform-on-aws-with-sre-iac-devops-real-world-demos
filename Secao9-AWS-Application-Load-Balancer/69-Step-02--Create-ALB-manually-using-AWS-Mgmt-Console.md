

# ############################################################################
# ############################################################################
# ############################################################################
# Git - Efetuando Push

git status
git add .
git commit -m "68. Step-01: Introduction to AWS Application Load Balancer."
git push
git status



# ############################################################################
# ############################################################################
# ############################################################################
#  69. Step-02: Create ALB manually using AWS Mgmt Console

## Step-02: Create ALB Basic Manually
### Step-02-01: Create EC2 Instance with Userdata
- Go to AWS Services -> EC2 -> Instances -> Launch Instances
- **Step 1: Choose an Amazon Machine Image (AMI):** Amazon Linux 2 AMI (HVM), SSD Volume Type
- **Step 2: Choose an Instance Type:** t2.micro
- **Step 3: Configure Instance Details:** 
  - Number of Instances: 2
  - Userdata: select `file` and reference  `terraform-manifests/app1-install.sh` for userdata
  - Rest all defaults  
- **Step 4: Add Storage:** leave to defaults
- **Step 5: Add Tags:** 
  - Key: Name
  - Value: ALB-Manual-Test-1
- **Step 6: Configure Security Group:** 
  - Security Group Name: ALB-Manual-TestSG1
  - Add SSH and HTTP rules for entire internet edge 0.0.0.0/0
- **Step 7: Review Instance Launch:** Click on Launch
- **Select an existing key pair or create a new key pair:** terraform-key
- Click on Launch Instance
- Verify once the EC2 Instance is created and wait for Instances to be in `2/2 checks passed`
- Access Instances and verify 
```
# Access App1 from both Instances
http://<public-ip-instance-1>/app1/index.html
http://<public-ip-instance-1>/app1/metadata.html
http://<public-ip-instance-2>/app1/index.html
http://<public-ip-instance-2>/app1/metadata.html
```

### Step-02-02: Create Target Group
- Go to AWS Services -> EC2 -> Target Groups -> Create target group
- **Choose a target type:** Instances
- **Target Group Name:** app1-tg
- **Protocol:** HTTP
- **Port:** 80
- **VPC:** default-vpc
- **Protocol Version:** HTTP1
- **Health Check Protocol:** HTTP
- **Health check path:** /app1/index.html
- **Advanced Health Check Settings - Port:** Traffic Port
- **Healthy threshold:** 5
- **Unhealthy threshold:** 2
- **Timeout:** 5 seconds
- **Interval:** 30 seconds
- **Success codes:** 200-399
- **Tags:** App = app1-tg
- Click **Next**
- **Register targets**
  - **Select EC2 Instances:** select EC2 Instances
  - **Ports for the selected instances:** 80
  - Click on **Include as pending below**
- Click on **Create target group**

## Step-02-03: Create Application Load Balancer
- Go to AWS Services -> EC2 -> Load Balancing -> Load Balancers -> Create Load Balancer
- **Select load balancer type:** Application Load Balancer
- **Step 1: Configure Load Balancer**
  - **Name:** alb-basic-test
  - **Scheme:** internet-facing
  - **IP address type:** ipv4
  - **Listeners:** 
    - Load Balancer Protocol: HTTP
    - Load Balancer Port: 80
  - **Availability Zones:**
    - VPC: default-vpc
    - Availability Zones: us-east-1a, us-east-1b, us-east-1c  (Verify first where EC2 Instances created)        
- **Step 2: Configure Security Settings** 
  - Click **Next**
- **Step 3: Configure Security Groups**
  - Assign a security group: create new security group
  - Security group name: loadbalancer-alb-sg
  - Rule: HTTP Port 80 from internet 0.0.0.0/0
- **Step 4: Configure Routing**
  - Target group: Existing Target Group
  - Name: app1-tg
  - Click **Next**
- **Step 5: Register Targets**
  - Click **Next Review**
- **Step 6: Review** Click on **Create**

## Step-02-04: Verify the following
- Wait for Load Balancer to be in `active` state
- Verify ALB Load Balancer 
  - Description Tab
  - Listeners Tab
  - Listeners Tab -> Rules
- Verify Target Groups
  -  They should be in `HEALTHY`
- Access using Load Balancer DNS
```
# Access Application
http://alb-basic-test-1565875067.us-east-1.elb.amazonaws.com
http://alb-basic-test-1565875067.us-east-1.elb.amazonaws.com/app1/index.html
http://alb-basic-test-1565875067.us-east-1.elb.amazonaws.com/app1/metadata.html
```

## Step-02-05: Clean-Up
- Delete Load Balacner
- Delete Target Groups
- Delete EC2 Instances