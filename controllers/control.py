import pymysql
import paho.mqtt.client as paho
import psycopg2.extras as pe
from app import *
from utils.db import mysql
from utils.db import connectPostgres
from flask import jsonify
from flask import flash, request
from flask_jwt_extended import jwt_required
import time
import json
from flask_jwt_extended import get_jwt_identity
from mqtt_connect import *
from datetime import datetime
from utils.mqtt import connect_mqtt
from utils.mqtt import publish
from utils.utils import format_query
from utils.utils import getErrorResponse
# API dieu khien thiet bi
client = connect_mqtt()
client.loop_start()
# Control mobile


@app.route('/h/device/<int:id>/control', methods=['PUT'], endpoint='controlHDevice')
@jwt_required()
def controlHDevice(id):
    content = None
    conn = None
    cursor = None
    current_user = get_jwt_identity()
    try:
        _json = request.json
        _device_name = None
        _device_detail = None
        _is_active = None
        _param = None
        if _json.get('device_name') is not None:
            _device_name = _json['device_name']
        if 'device_detail' in _json:
            _device_detail = _json['device_detail']
        if 'is_active' in _json:
            _is_active = _json['is_active']
        if 'param' in _json:
            _param = _json['param']
        _updated = datetime.utcnow()
        _json['id'] = id
        _json['userID'] = current_user

        # get room id which contains device
        # conn = mysql.connect()
        conn = connectPostgres()
        cursor = conn.cursor(cursor_factory=pe.DictCursor)
        cursor.execute(f"SELECT room_id FROM devices_room WHERE id={id}")
        row = cursor.fetchone()
        room_id = row[0]
        _json["room_id"] = room_id

        # client.publish("/control_device", payload=json.dumps(_json))
        pub_data = {
            "id": _json["id"],
            "is_active": _json["is_active"],
            "param": _param
        }
        print(f"room: {room_id}")
        publish(client, msg=json.dumps(pub_data),
                topic=f"hieu_control_device_of_room_{room_id}")

        # update device data
        sql = f"UPDATE devices_room SET {format_query('device_name=',_device_name,tail=',')}\
            {format_query('device_detail=',_device_detail,',')}\
                {format_query('is_active=',_is_active,',')}\
                    {format_query('param=',_param)}\
                        WHERE id={id}"
        x = cursor.execute(sql)
        conn.commit()

        # return data
        res = jsonify({"deviceRoom": _json})
        return res
    except Exception as e:
        res = jsonify({
            "message": "Control device fail.",
            "err": str(e)
        })
        res.status_code = 500
        return res
    finally:
        if cursor is not None:
            cursor.close()
        if conn is not None:
            conn.close()


@app.route('/h/device/no_auth/<int:id>/control', methods=['PUT'], endpoint='controlHDeviceWithoutAuth')
def controlHDeviceWithoutAuth(id):
    content = None
    conn = None
    cursor = None
    # current_user = get_jwt_identity()
    try:
        _json = request.json
        print(type(_json))
        _device_name = None
        _device_detail = None
        _is_active = None
        _param = None
        if _json.get('device_name') is not None:
            _device_name = _json['device_name']
        if 'device_detail' in _json:
            _device_detail = _json['device_detail']
        if 'is_active' in _json:
            _is_active = _json['is_active']
        if 'param' in _json:
            _param = _json['param']
        _updated = datetime.utcnow()
        _json['id'] = id
        # _json['userID'] = current_user

        # get room id which contains device
        # conn = mysql.connect()
        conn = connectPostgres()
        cursor = conn.cursor()
        cursor.execute("SELECT room_id FROM devices_room WHERE id=%s", (id))
        row = cursor.fetchone()
        room_id = row[0]
        _json["room_id"] = room_id

        # client.publish("/control_device", payload=json.dumps(_json))
        pub_data = {
            "id": _json["id"],
            "is_active": _json["is_active"],
            "param": _param
        }
        publish(client, msg=json.dumps(pub_data),
                topic=f"hieu_control_device_of_room_{room_id}")

        # update device data
        sql = f"UPDATE devices_room SET {format_query('device_name=',_device_name,tail=',')}\
            {format_query('device_detail=',_device_detail,',')}\
                {format_query('is_active=',_is_active,',')}\
                    {format_query('param=',_param)}\
                        WHERE id=%s"
        x = cursor.execute(sql, (id))
        conn.commit()

        # return data
        res = jsonify({"deviceRoom": _json})
        return res
    except Exception as e:
        res = jsonify({
            "message": "Control device fail.",
            "err": str(e)
        })
        res.status_code = 500
        return res
    finally:
        if cursor is not None:
            cursor.close()
        if conn is not None:
            conn.close()


@app.route('/device/<int:id>/control', methods=['PUT'], endpoint='controlDevice')
@jwt_required()
def controlDevice(id):
    content = None
    conn = None
    cursor = None
    current_user = get_jwt_identity()
    try:
        _json = request.json
        _is_active = _json['is_active']
        _param = _json['param']
        _json['id'] = id
        _json['userID'] = current_user
        client.publish("/iot_project_nhom04", payload=json.dumps(_json))
        print("success")
        sql = "UPDATE devices_room SET is_active=%s, param=%s WHERE id=%s"
        data = (_is_active, _param, id)
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute(sql, data)
        conn.commit()

        res = jsonify(_json)
        return res
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()
