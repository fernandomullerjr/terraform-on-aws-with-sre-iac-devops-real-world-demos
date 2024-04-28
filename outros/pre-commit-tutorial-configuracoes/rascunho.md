








~~~~bash
fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos$ terraform fmt -recursive
╷
│ Error: Invalid attribute name
│
│   on Secao7-AWS-EC2-instances-and-Security-groups/59-null_resource__terraform_data.tf line 9, in resource "terraform_data" "cluster":
│    9:   triggers_replace = aws_instance.cluster.[*].id
│
│ An attribute name is required after a dot.
╵

╷
│ Error: Invalid attribute name
│
│   on Secao7-AWS-EC2-instances-and-Security-groups/59-null_resource__terraform_data.tf line 14, in resource "terraform_data" "cluster":
│   14:     host = aws_instance.cluster.[0].public_ip
│
│ An attribute name is required after a dot.
╵


~~~~


- Comentando os triggers e host, que usavam [] e eram inválidos no fmt:

/home/fernando/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos/Secao7-AWS-EC2-instances-and-Security-groups/59-null_resource__terraform_data.tf

~~~~tf
resource "aws_instance" "cluster" {
  count = 3

  # ...
}

resource "terraform_data" "cluster" {
  # Replacement of any instance of the cluster requires re-provisioning
  #triggers_replace = aws_instance.cluster.[*].id
  triggers_replace = aws_instance.cluster.id

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    #host = aws_instance.cluster.[0].public_ip
    host = aws_instance.cluster.public_ip
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "bootstrap-cluster.sh ${join(" ", aws_instance.cluster.*.private_ip)}",
    ]
  }
}
~~~~




- ERRO

~~~~bash

fernando@debian10x64:~/cursos/terraform/terraform-on-aws-with-sre-iac-devops-real-world-demos$ git commit -m "teste2"
Terraform fmt............................................................Passed
[INFO] Installing environment for https://github.com/commitizen-tools/commitizen.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
An unexpected error has occurred: CalledProcessError: command: ('/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/bin/python', u'/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/bin/pip', 'install', '.')
return code: 1
expected return code: 0
stdout: (none)
stderr:
    Traceback (most recent call last):
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/bin/pip", line 5, in <module>
        from pip._internal.cli.main import main
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_internal/cli/main.py", line 9, in <module>
        from pip._internal.cli.autocompletion import autocomplete
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_internal/cli/autocompletion.py", line 10, in <module>
        from pip._internal.cli.main_parser import create_main_parser
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_internal/cli/main_parser.py", line 8, in <module>
        from pip._internal.cli import cmdoptions
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_internal/cli/cmdoptions.py", line 24, in <module>
        from pip._internal.cli.parser import ConfigOptionParser
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_internal/cli/parser.py", line 12, in <module>
        from pip._internal.configuration import Configuration, ConfigurationError
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_internal/configuration.py", line 20, in <module>
        from pip._internal.exceptions import (
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_internal/exceptions.py", line 13, in <module>
        from pip._vendor.requests.models import Request, Response
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_vendor/requests/__init__.py", line 43, in <module>
        from pip._vendor import urllib3
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_vendor/urllib3/__init__.py", line 13, in <module>
        from .connectionpool import HTTPConnectionPool, HTTPSConnectionPool, connection_from_url
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_vendor/urllib3/connectionpool.py", line 40, in <module>
        from .response import HTTPResponse
      File "/home/fernando/.cache/pre-commit/repoFAa_5H/py_env-python3/lib/python3.8/site-packages/pip/_vendor/urllib3/response.py", line 5, in <module>
        import zlib
    ModuleNotFoundError: No module named 'zlib'

Check the log at /home/fernando/.cache/pre-commit/pre-commit.log

~~~~









## PENDENTE

- Resolver erro ao utilizar pre-commit:
ModuleNotFoundError: No module named 'zlib'