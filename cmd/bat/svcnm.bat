@echo off

tasklist /svc /FI "PID eq %1%"
