#!/bin/sh


configDir="/etc/ceilometer"
configFile=${configFile:-"${configDir}/ceilometer.conf"}
debug=${fipromDebug:-"false"}
rabbitmqHost=${fipromRabbitMQHost:-""}
rabbitmqUser=${fipromRabbitMQUser:-""}
rabbitmqPassword=${fipromRabbitMQPassword:-""}
meteringSecret=${fipromMeteringSecret:-""}
dispatcherUrl=${dispatcherUrl:-"http://localhost:9099/"}


if [ ! -e "${configFile}" ]; then
    mkdir -p ${configDir}
    cp ceilometer.conf.example ${configFile}

    sed -i "s|VAR_DEBUG|${debug}|g"                         ${configFile}
    sed -i "s|VAR_RABBITMQ_URL|${rabbitmqHost}|g" 	        ${configFile}
    sed -i "s|VAR_RABBITMQ_USER|${rabbitmqUser}|g" 	        ${configFile}
    sed -i "s|VAR_RABBITMQ_PASSWORD|${rabbitmqPassword}|g" 	${configFile}
    sed -i "s|VAR_METERING_SECRET|${meteringSecret}|g" 	    ${configFile}
    sed -i "s|VAR_DISPATCHER_URL|${dispatcherUrl}|g"        ${configFile}

    sed -i 's/VAR_.*//g'    ${configFile}

fi


cat ${configFile}

exec ceilometer-collector --config-file ${configFile}
