#!/usr/bin/env python3
"""
Sample Flask application for Kubernetes deployment
"""

from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

@app.route('/')
def index():
    """Root endpoint"""
    hostname = socket.gethostname()
    return jsonify({
        'message': 'Hello from Kubernetes!',
        'hostname': hostname,
        'version': os.getenv('APP_VERSION', '1.0.0')
    })

@app.route('/health')
def health():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'service': 'sample-app'
    }), 200

@app.route('/ready')
def ready():
    """Readiness check endpoint"""
    return jsonify({
        'status': 'ready',
        'service': 'sample-app'
    }), 200

@app.route('/metrics')
def metrics():
    """Metrics endpoint for Prometheus"""
    # In a real application, you would collect actual metrics
    return "# HELP http_requests_total Total number of HTTP requests\n" \
           "# TYPE http_requests_total counter\n" \
           "http_requests_total 100\n", 200, {'Content-Type': 'text/plain'}

if __name__ == '__main__':
    port = int(os.getenv('PORT', 8080))
    app.run(host='0.0.0.0', port=port, debug=False)

