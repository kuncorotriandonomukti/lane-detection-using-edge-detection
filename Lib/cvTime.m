function [logs,time] = cvTime(x)
    logs = [];
    for i = 1:5
        x = 1+i;
        logs(i) = {[logs;x]};
    end
    sprintf('waktu eklogssekusi %s %f/detik',proses,x);
end