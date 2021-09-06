@echo off

:: Don't change me
set true=1==1
set false=1==0

:: BANANO payout address (The address that will receive payments)
set payout_address="ban_1boompow14irck1yauquqypt7afqrh8b6bbu5r93pc6hgbqs7z6o99frcuym"

:: Desired work type, options are "ondemand", "precache", "any" (default)
set desired_work_type="any"

:: Send work_generate to the work server asynchronously
:: May increase performance, but will use more system resources
:: To enable change to:
:: set async_mode=%true%
set async_mode=%false%

:: Limit logging
:: Will only log stats updates, instead of all queue-related information
set limit_logging=%false%

:: Optional delay before starting a BoomPow client
set start_delay_seconds=3

:: You may need to change the "--gpu 0:0" option to 1:0 or 0:1 depending on system configuration
:: If you are using multiple GPUs, you can specify multiple --gpu options, e.g. "--gpu 0:0 --gpu 1:0 --gpu 2:0"
:: If you are using CPU-only, you should remove the "--gpu 0:0" option and add "--cpu-threads X" where X is max number of threads
echo Starting PoW Service minimized...
start /min "PoW Service" cmd /c ".\bin\windows\nano-work-server.exe --gpu 0:0 -l 127.0.0.1:7000 && pause"

echo PoW Service started.
timeout %start_delay_seconds%

echo.
echo Starting BoomPow Client...
if %async_mode% (
    if %limit_logging% (
        py bpow_client.py --payout %payout_address% --work %desired_work_type% --async_mode --limit-logging
    ) else {
        py bpow_client.py --payout %payout_address% --work %desired_work_type% --async_mode
    }
) else (
    if %limit_logging% (
        py bpow_client.py --payout %payout_address% --work %desired_work_type% --limit-logging
    ) else (
        py bpow_client.py --payout %payout_address% --work %desired_work_type%
    )
)

pause
