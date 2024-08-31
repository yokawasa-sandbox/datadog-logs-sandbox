# ベースイメージ
FROM nginx:alpine

# Copying website files to the container
COPY index.html /usr/share/nginx/html/index.html

# Copying NGINX configuration (the default.conf) to the container
COPY default.conf /etc/nginx/conf.d

## Set Environment
# The NGINX port
ENV NGINX_PORT=80

## Set Labels for Datadog
##########################
# Minimum required labels
# LABEL "com.datadoghq.ad.logs"='[{"source": "nginx", "service": "nginx-service"}]'

# Credit card number masking
# LABEL "com.datadoghq.ad.logs"='[{"source": "nginx", "service": "nginx-service", "log_processing_rules": [{"type": "mask_sequences", "name": "mask_credit_cards","replace_placeholder": "[masked_credit_card]", "pattern" : "(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})" }]}]'

# Email address masking
LABEL "com.datadoghq.ad.logs"='[{"source": "nginx", "service": "nginx-service", "log_processing_rules": [{"type": "mask_sequences", "name": "mask_param_email","replace_placeholder": "$1[masked_email]", "pattern" : "(param=)[^@]*@(.*)" }]}]'
##########################


# NGINX サービスの起動
CMD ["nginx", "-g", "daemon off;"]
