@CALL %~dp0\config.cmd %1 %2 %3 %4 %5 %6 %7
@IF [%ConfigSuccess%] == [0] GOTO Fail

@echo Creating windows_run-ioc-in-docker.cmd and windows_run-typhos-gui.cmd...

IF %AdsDeployUseDocker% EQU 1 (
    %RunDocker% %DockerImage% "find '%IocMountPath%/iocBoot/' -maxdepth 1 -type d ! -path '%IocMountPath%/iocBoot/' -exec python /ads-deploy/ads_deploy/windows/make_scripts.py {} '%DeployRoot%' '%SolutionDir%' '%SolutionFilename%' '%IocMountPath%' '%DockerImage%' \;"
) ELSE (
    goto :Fail
)

@echo Done
@GOTO :eof

:Fail
@echo ** FAILED **
