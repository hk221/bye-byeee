print("Hello")
import time
import smbus2
import json
import paho.mqtt.client as mqtt
import requests,time,random
from datetime import datetime
from google.oauth2 import service_account
from google.auth.transport.requests import AuthorizedSession


loopcounter = 0
while loopcounter < 20:
    #--------------------BMP 280 SENSOR CODE-------------------------------------------#

    # bmp280.py
# Simple python script to read out the temperature of the
# BMP280 temperature and pressure sensor

    import smbus2
    import time

    # BMP280 bus address
    bmp_addr = 0x77

    # Get access to the bus bus
    bus = smbus2.SMBus(1)

    # Setup the config register

    bus.write_byte_data(bmp_addr, 0xf5, (5<<5))
    bus.write_byte_data(bmp_addr, 0xf4, ((5<<5) | (3<<0)))

    # Sensor is set up and will do a measurement every 1s

    dig_T1 = bus.read_word_data(bmp_addr, 0x88)
    dig_T2 = bus.read_word_data(bmp_addr, 0x8A)
    dig_T3 = bus.read_word_data(bmp_addr, 0x8C)

    if(dig_T2 > 32767):
        dig_T2 -= 65536
    if(dig_T3 > 32767):
        dig_T3 -= 65536


    # Read the raw temperature
    d1 = bus.read_byte_data(bmp_addr, 0xfa)
    d2 = bus.read_byte_data(bmp_addr, 0xfb)
    d3 = bus.read_byte_data(bmp_addr, 0xfc)

    adc_T = ((d1 << 16) | (d2 << 8) | d3) >> 4

    #print ("adc_T: " + str(adc_T))

    # Calculate temperature
    var1 = ((((adc_T>>3) - (dig_T1<<1))) * (dig_T2)) >> 11;
    var2 = (((((adc_T>>4) - (dig_T1)) * ((adc_T>>4) - (dig_T1))) >> 12) * (dig_T3)) >> 14;
    t_fine = var1 + var2;
    T = (t_fine * 5 + 128) >> 8;
    T = T / 100

    #print("t_fine:", t_fine)


    print("Temperature: " +str(T))
    time.sleep(1)

    dig_P1 = bus.read_word_data(bmp_addr, 0x8E)
    dig_P2 = bus.read_word_data(bmp_addr, 0x90)
    dig_P3 = bus.read_word_data(bmp_addr, 0x92)
    dig_P4 = bus.read_word_data(bmp_addr, 0x94)
    dig_P5 = bus.read_word_data(bmp_addr, 0x96)
    dig_P6 = bus.read_word_data(bmp_addr, 0x98)
    dig_P7 = bus.read_word_data(bmp_addr, 0x9A)
    dig_P8 = bus.read_word_data(bmp_addr, 0x9C)
    dig_P9 = bus.read_word_data(bmp_addr, 0x9E)

    if(dig_P2 > 32767):
        dig_P2 -= 65536
    if(dig_P3 > 32767):
        dig_P3 -= 65536
    if(dig_P4 > 32767):
        dig_P4 -= 65536
    if(dig_P5 > 32767):
        dig_P5 -= 65536
    if(dig_P6 > 32767):
        dig_P6 -= 65536
    if(dig_P7 > 32767):
        dig_P7 -= 65536
    if(dig_P8 > 32767):
        dig_P8 -= 65536
    if(dig_P9 > 32767):
        dig_P9 -= 65536


    #code to get the burst data from the sensor for pressure
    # burst_data = bus.read_i2c_block_data(bmp_addr, 0xf7, 3)

    # # Extract individual values from burst read
    # p1, p2, p3 = burst_data[0], burst_data[1], burst_data[2]

    # adc_P = ((p1 << 16) | (p2 << 8) | p3) >> 4
    # print("Raw Pressure:", adc_P)

    # # Continue with your pressure calculation code (uncomment and modify as needed)
    # # var1 = t_fine - 128000;
    # # var2 = var1 * var1 * dig_P6;
    # # ... (rest of the pressure calculation code)

    # # Print the individual pressure components
    # print("p1:", p1)
    # print("p2:", p2)
    # print("p3:", p3)

    # Read the raw pressure
    p1 = 59
    p2 = 135
    p3 = 80

    adc_P = ((p1 << 16) | (p2 << 8) | p3) >> 4
    #print (p1)
    #print (p2)
   # print (p3)
   # print ("adcP:",adc_P)

    # Calculate pressure

    var1 = t_fine - 128000;
    var2 = var1 * var1 * dig_P6;
    var2 = var2 + ((var1*dig_P5)<<17);
    var2 = var2 + ((dig_P4)<<35);
    var1 = ((((var1 * var1 * dig_P3)>>8) + ((var1 * dig_P2)<<12)));
    var1 = ((1<<47) + var1) * dig_P1 >> 33;
    if var1 == 0:
        P = 0
    else:
        P = 1048576 - adc_P;
        P = (((P<<31) - var2) * 3125) / var1;
        var1 = int((dig_P9 * (P / (1 << 13)) * (P / (1 << 13))) / (1 << 25))

        var2 = int((dig_P8 * P) / (1 << 19))

        P = int(((P + var1 + var2) / (1 << 8)) + (dig_P7 << 4))

        P = P / 25600

        print("Pressure: " + str(P))




    # --------------------Si7021 SENSOR CODE-------------------------------------------#
    si7021_ADD = 0x40  # I2C bus address for the sensor
    si7021_READ_TEMPERATURE = 0xF3  # Command to read temperature
    si7021_READ_HUMIDITY = 0xF5  # Command to read humidity

    bus = smbus2.SMBus(1)

    # Set up a write transaction that sends the command to measure temperature
    cmd_meas_temp = smbus2.i2c_msg.write(si7021_ADD, [si7021_READ_TEMPERATURE])
    # Set up a read transaction that reads two bytes of data for temperature
    read_temp_result = smbus2.i2c_msg.read(si7021_ADD, 2)

    # Set up a write transaction that sends the command to measure humidity
    cmd_meas_humidity = smbus2.i2c_msg.write(si7021_ADD, [si7021_READ_HUMIDITY])
    # Set up a read transaction that reads two bytes of data for humidity
    read_humidity_result = smbus2.i2c_msg.read(si7021_ADD, 2)

    # Execute the transactions with a small delay between them
    bus.i2c_rdwr(cmd_meas_temp)
    time.sleep(0.1)
    bus.i2c_rdwr(read_temp_result)

    bus.i2c_rdwr(cmd_meas_humidity)
    time.sleep(0.1)
    bus.i2c_rdwr(read_humidity_result)

    # Convert the result to an int for temperature
    raw_temperature = int.from_bytes(read_temp_result.buf[0] + read_temp_result.buf[1], 'big')
    # Convert the result to an int for humidity
    raw_humidity = int.from_bytes(read_humidity_result.buf[0] + read_humidity_result.buf[1], 'big')

    # According to the Si7021 datasheet, the temperature is a 16-bit value with a resolution of 0.01 degrees Celsius
    temperature_celsius = ((175.72 * raw_temperature) / 65536) - 46.85
    # According to the Si7021 datasheet, the humidity is a 16-bit value with a resolution of 0.01%
    humidity_percentage = ((125 * raw_humidity) / 65536) - 6

    print("Temperature:", temperature_celsius)
    print("Humidity:", humidity_percentage)

    # Create a dictionary to store sensor data
    sensor_data = {
        "temperature": f"{temperature_celsius:.1f}",
        "humidity": f"{humidity_percentage:.1f}",
        "airPressure": f"{P:.1f}",
        #"airPressure": "high" if sensor.pressure > 1013 else "low",

        # "timestamp": int(time.time())
    }

    # Serialize the data to a JSON-encoded byte string
    json_message = json.dumps(sensor_data).encode('utf-8')
    json_message = json_message.decode('utf-8')

    print("Serialized JSON message:", json_message)



    #--------------------Database Put Code -------------------------------------------#



    current_datetime = datetime.now()
    ct = current_datetime.time()
    ft = ct.strftime("%H%M%S")
    print(str(ft))

    #print("Time:", current_datetime.time())

    db = "https://smart-wardrobe-9f738-default-rtdb.europe-west1.firebasedatabase.app/"

   

    n = 0
    while n < 1:
        path = "weather_data/{}/{}.json".format(int(ft), int(n))
        
        # Update data to include temperature reading
        data = {
            "current_temp": temperature_celsius,
            "current_humidity": humidity_percentage,
            "current_pressure": P
        }

        print("Writing {} to {}".format(data, path))
        response = requests.put(db + path, json=data)

        if response.ok:
            print("Ok")
        else:
            raise ConnectionError("Could not write to database: {}".format(response.text))
        
        time.sleep(1)
        n += 1

    #------------------------------OUTFIT ALGORITHM---------------------------------#



    def suggest_clothing(temperature, humidity, pressure):
        clothing_suggestions = {}

        # Set your custom thresholds for temperature, humidity, and pressure
        hot_temp_threshold = 25
        #cold_temp_threshold = 10
        high_humidity_threshold = 60
        low_pressure_threshold = 1013

        if temperature > hot_temp_threshold and humidity > high_humidity_threshold:
            # Hot and Humid
            clothing_suggestions["nohat"] = "nohat"
            clothing_suggestions["coldtop"] = "coldtop"
            clothing_suggestions["coldbottom"] = "coldbottom"
            clothing_suggestions["coldshoes"] = "coldshoes"

        elif temperature > hot_temp_threshold and humidity <= high_humidity_threshold:
            # Hot and Not Humid
            clothing_suggestions["nohat"] = "nohat"
            clothing_suggestions["coldtop"] = "coldtop"
            clothing_suggestions["coldbottom"] = "coldbottom"
            clothing_suggestions["hotshoes"] = "hotshoes"

        elif temperature < hot_temp_threshold and humidity > high_humidity_threshold:
            # Not Hot and Humid
            clothing_suggestions["hat"] = "hat"
            clothing_suggestions["hottop"] = "hottop"
            clothing_suggestions["hotbottom"] = "hotbottom"
            clothing_suggestions["hotshoes"] = "hotshoes"

        elif temperature < hot_temp_threshold and humidity <= high_humidity_threshold:
            # Not Hot and Not Humid
            clothing_suggestions["hat"] = "hat"
            clothing_suggestions["hottop"] = "hottop"
            clothing_suggestions["hotbottom"] = "hotbottom"
            clothing_suggestions["hotshoes"] = "hotshoes"

        if pressure < low_pressure_threshold:
            # Suggestions for low pressure
            clothing_suggestions["puffer"] = "puffer"

        elif pressure >= low_pressure_threshold:
            clothing_suggestions["nopuffer"] = "nopuffer"   

        return clothing_suggestions

    temperature_value = temperature_celsius  # Replace with the actual temperature value
    humidity_value = humidity_percentage  # Replace with the actual humidity value
    pressure_value = P # Replace with the actual pressure value
    clothing_to_wear = suggest_clothing(temperature=temperature_value, humidity=humidity_value, pressure=pressure_value)

    # Convert the dictionary to a JSON string
    clothing_json = json.dumps(clothing_to_wear)

    #print(clothing_json)


    combined_json = f"{clothing_json[:-1]}, {json_message[1:]}"
    print(combined_json)

    #--------------------MQTT CODE-------------------------------------------#

    client = mqtt.Client()
    client.connect("mqtt-dashboard.com",port=1883)

    #client.tls_set(ca_certs="mosquitto.org.crt", certfile="client (1).crt",keyfile="client.key")




    def on_message(client, userdata, message) :
        print("Received message:{} on topic {}".format(message.payload, message.topic))


    client.loop_start()
    client.subscribe("IC.embedded/byebye/")
    client.on_message = on_message

    MSG_INFO_CLOTHING = client.publish("IC.embedded/byebye/",combined_json)
    #MSG_INFO_JSON = client.publish("IC.embedded/byebye/",json_message)
    mqtt.error_string(MSG_INFO_CLOTHING.rc)
    #mqtt.error_string(MSG_INFO_JSON.rc)

    time.sleep(5)
    client.loop_stop()

        
    loopcounter += 1
    time.sleep(25)
    
print("Finished loop. Exiting.")













