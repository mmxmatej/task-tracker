from flask import Flask, jsonify
import os
import psutil

app = Flask(__name__)

@app.route('/info', methods=['GET'])
def get_system_info():
    info = {
        "cpu_percent": psutil.cpu_percent(interval=1),
        "memory": psutil.virtual_memory()._asdict(),
        "disk": psutil.disk_usage('/')._asdict(),
        "hostname": os.uname().nodename
    }
    return jsonify(info)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)  # Changed to port 80
