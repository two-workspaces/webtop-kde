FROM linuxserver/webtop:ubuntu-kde-54e166d5-ls188

# Upstream starts Xvfb with a 15360x8640 screen, which pins ~600 MB for the
# framebuffer alone and OOM-kills the desktop on Railway's 512 MB Trial plan.
# 4K is plenty; Selkies still resizes the desktop to the browser window.
ENV MAX_RES=3840x2160

# ponytail: one custom-init script adds an unauthenticated /healthcheck
# location for Railway's healthcheck prober; everything else is stock.
COPY root/ /
RUN chmod +x /railway-gate.sh /custom-cont-init.d/20-healthcheck /custom-services.d/drop-file-cache /usr/local/bin/drop-file-cache

# Free plan (0.5 GB): serve a "needs 1 GB" page instead of starting the desktop (see railway-gate.sh).
ENTRYPOINT ["/railway-gate.sh"]
