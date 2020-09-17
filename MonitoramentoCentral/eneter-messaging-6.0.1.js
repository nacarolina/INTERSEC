
/**
 * Event arguments used for receiving messages from the broker.
 * @class
 */
function BrokerMessageReceivedEventArgs(messageTypeId, message, receivingError)
{
    /**
     * Returns type of the notified event.
     */
    this.MessageTypeId = messageTypeId;
    
    /**
     * Returns the notified message.
     */
    this.Message = message;
    
    /**
     * Returns the error detected during receiving of the message.
     */
    this.ReceivingError = receivingError;
}

/**
 * Broker client that can publish and subscribe messages in the broker.
 * @class
 * @augments AttachableDuplexOutputChannelBase
 * 
 * @example
 * // Create the duplex output channel.
 * var anOutputChannel = new WebSocketDuplexOutputChannel("ws://127.0.0.1:8077/MyBroker/", null);
 * 
 * // Create BrokerClient
 * var aBrokerClient = new DuplexBrokerClient();
 * 
 * // Handler processing notification messages from the broker.
 * aBrokerClient.onBrokerMessageReceived = onBrokerMessageReceived;
 * 
 * // Attach output channel and be able to send messages and receive responses.
 * aBrokerClient.attachDuplexOutputChannel(anOutputChannel);
 * 
 * ...
 * 
 * // Subscribe to event from the broker.
 * aBrokerClient.subscribe("MyTimeEvent");
 * 
 * ...
 * 
 * // This is how you can unsubscribe.
 * aBrokerClient.unsubscribe("MyTimeEvent");
 * 
 * // Handler processing notifications from the broker.
 * function onBrokerMessageReceived(brokerMessageReceivedEventArgs) {
 * 
 *     if (brokerMessageReceivedEventArgs.MessageTypeId == "MyTimeEvent") {
 *         // Deserialize the event.
 *         var aValue = JSON.parse(brokerMessageReceivedEventArgs.Message);
 *         ...
 *     }
 *     else if (brokerMessageReceivedEventArgs.MessageTypeId == "SomeOtherEvent") {
 *     ...
 *     }
 * }
 * 
 * ...
 * 
 * // You also can send notification events to the broker.
 * // Broker will forward them to subscribers subscribed for that event.
 * 
 * // Declaring event class.
 * function MyEvent(value1, value2) {
 *     this.Value1 = value1;
 *     this.Value2 = value;
 * }
 * 
 * // Publishing event via the broker.
 * var anEvent = new MyEvent(123, 456);
 * var aSerializedEvent = JSON.stringify(anEvent);
 * aBrokerClient.sendMessage("MyEvent", aSerializedEvent);
 * 
 */
function DuplexBrokerClient()
{
    // Data message used for the communication with the broker.
    function BrokerMessage()
    {
        this.Request = null;
        this.MessageTypes = null;
        this.Message = null;
    };
    
    // Ensure that inherited classes will not share the same instance of the parent class.
    AttachableDuplexOutputChannelBase.call(this);
    
    // Store the context of this class.
    var mySelf = this;
    
    /**
     * The event is invoked when the observed event is received from the broker.
     * @param {BrokerMessageReceivedEventArgs} brokerMessageReceivedEventArgs
     */
    this.onBrokerMessageReceived = function(brokerMessageReceivedEventArgs) {};
    
    /**
     * Publishes the event via the broker.<br/>
     * It means sends the message to the broker. When the broker receives the message it will notified all subscribers
     * which are subscribed for this message.
     * @param {String} eventId identifies the event
     * @param {String} serializedMessage message content. If the message is not a primitive type or string then the input parameter expects the message is already serialized!
     */
    this.sendMessage = function(eventId, serializedMessage)
    {
        var aBrokerMessage = new BrokerMessage();
        aBrokerMessage.Request = 5; // enum value for Publish
        aBrokerMessage.MessageTypes = [eventId];
        aBrokerMessage.Message = serializedMessage;
        
        send(this.getAttachedDuplexOutputChannel(), aBrokerMessage);
    };
    
    /**
     * Subscribes the client for the event or list of events.
     * @param {(String|String[])} eventId identifies event or list of events to be subscribed in the broker.
     */
    this.subscribe = function(eventId)
    {
        var aMessageTypes = null;
        if (eventId instanceof Array)
        {
            aMessageTypes = eventId;
        }
        else
        {
            aMessageTypes = [eventId];
        }
        
        var aBrokerMessage = new BrokerMessage();
        aBrokerMessage.Request = 0; // enum value for Subscribe
        aBrokerMessage.MessageTypes = aMessageTypes;
        
        send(this.getAttachedDuplexOutputChannel(), aBrokerMessage);
    };
    
    /**
     * Unsubscribes the client from the specified event or list of events.
     * @param {(string|string[])} eventId identifies event or list of events to be unsubscribed from the broker.
     */
    this.unsubscribe = function(eventId)
    {
        var aMessageTypes = null;
        if (eventId instanceof Array)
        {
            aMessageTypes = eventId;
        }
        else
        {
            aMessageTypes = [eventId];
        }
        
        var aBrokerMessage = new BrokerMessage();
        aBrokerMessage.Request = 2; // enum value for Unsubscribe
        aBrokerMessage.MessageTypes = aMessageTypes;
        
        send(this.getAttachedDuplexOutputChannel(), aBrokerMessage);
    };
    
    var send = function(outputChannel, brokerMessage)
    {
        if (outputChannel === null)
        {
            throw "Failed to send the message because the output channel is not attached.";
        }
        
        try
        {
            var aSerializedMessage = JSON.stringify(brokerMessage);
            outputChannel.sendMessage(aSerializedMessage);
        }
        catch (err)
        {
            console.error("Failed to send the message.", err);
            throw err;
        }
    };
    
    // Override the message handler from the base class.
    this._onResponseMessageReceived = function(duplexChannelMessageEventArgs)
    {
        var aBrokerMessage = null;
        var anError = null;
        
        try
        {
            // Deserialize incoming message.
            aBrokerMessage = JSON.parse(duplexChannelMessageEventArgs.Message);
        }
        catch (err)
        {
            anError = err;
        }

        // Raise the event.
        var aBrokerMessageReceivedEventArgs = new BrokerMessageReceivedEventArgs(aBrokerMessage.MessageTypes[0], aBrokerMessage.Message, anError);
        mySelf.onBrokerMessageReceived(aBrokerMessageReceivedEventArgs);
    };
};
DuplexBrokerClient.prototype = new AttachableDuplexOutputChannelBase();
DuplexBrokerClient.constructor = DuplexBrokerClient;

/**
 * Event arguments for receiving a response message from DuplexTypedMessageSender.
 * @class
 */
function TypedResponseReceivedEventArgs(responseMessage, receivingError)
{
    /**
     * Returns object of received message. (it is already deserialized message)
     */
    this.ResponseMessage = responseMessage;

    /**
     * Returns an exception detected during receiving the response message.
     */
    this.ReceivingError = receivingError;
};

/**
 * Sends request messages and receives response messages.
 * Messages do not have to be String or byte[] but they can be be data structures (classes).
 * Messages are serialized/deserialized using Json.
 * 
 * @class
 * @augments AttachableDuplexOutputChannelBase
 * 
 * @example
 * // Create the duplex output channel.
 * var anOutputChannel = new WebSocketDuplexOutputChannel("ws://127.0.0.1:8890/MyService/", null);
 * 
 * // Create DuplexTypedMessageSender.
 * var aSender = new DuplexTypedMessageSender();
 * 
 * // Subscribe to receive response messsages.
 * aSender.onResponseReceived = onResponseReceived;
 * 
 * // Attach output channel and be able to send messages and receive responses.
 * aSender.attachDuplexOutputChannel(anOutputChannel);
 * 
 * ...
 * 
 * // Message which shall be sent. 
 * function MessageData(name, number) {
 *     this.Name = name;
 *     this.Number = number;
 * };
 * 
 * // Send a message.
 * var aMessage = new MessageData("Hello World.", 123);
 * aSender.sendRequestMessage(aMessage);
 * 
 * ...
 * 
 * // Detach output channel and stop listening to responses.
 * aSender.detachDuplexOutputChannel();
 * 
 * ...
 * 
 * // Event handler processing received response messages.
 * function onResponseReceived(typedResponseReceivedEventArgs) {
 * 
 *     // Note: aMessage is already deserialized message.
 *     var aMessage = typedResponseReceivedEventArgs.ResponseMessage;
 *     ...
 * }
 * 
 */
function DuplexTypedMessageSender()
{
    // Ensure that inherited classes will not share the same instance of the parent class.
    AttachableDuplexOutputChannelBase.call(this);
    
    // Store the context of this class.
    var mySelf = this;
    
    /**
     * The event is invoked when a response message was received.
     * @param {TypedResponseReceivedEventArgs} responseMessage received response message. 
     */
    this.onResponseReceived = function(responseMessage) {};
    
    /**
     * Serializes the given message and sends it.
     * @param message object that shall be serialized and sent.
     * @throws Throws error message if sending fails.
     */
    this.sendRequestMessage = function(message)
    {
        if (this.isDuplexOutputChannelAttached() === false)
        {
            throw "Failed to send the message because the output channel is not attached.";
        }

        try
        {
            var aSerializedMessage = JSON.stringify(message);
            this.getAttachedDuplexOutputChannel().sendMessage(aSerializedMessage);
        }
        catch (err)
        {
            console.error("Failed to send the message.", err);
            throw err;
        }
    };
    
    // Overrides the message handler from the base class.
    // It deserializes the received message and invokes event notifying the response message was received.
    this._onResponseMessageReceived = function(duplexChannelMessageEventArgs)
    {
        var anObject = null;
        var anError = null;
        
        try
        {
            // Deserialize incoming message.
            anObject = JSON.parse(duplexChannelMessageEventArgs.Message);
        }
        catch (err)
        {
            anError = err;
        }

        // Raise the event.
        var aResponseReceivedEventArgs = new TypedResponseReceivedEventArgs(anObject, anError);
        mySelf.onResponseReceived(aResponseReceivedEventArgs);
    };
};
DuplexTypedMessageSender.prototype = new AttachableDuplexOutputChannelBase();
DuplexTypedMessageSender.constructor = DuplexTypedMessageSender;

/**
 * Base class for all communication components that need to attach duplex output channel.
 * This is meant to be abstract class. Therefore do not use instantiate it directly.
 * @class
 * @abstract
 */
function AttachableDuplexOutputChannelBase()
{
    // Private data members.
    var myOutputChannel = null;

    /**
     * The event is invoked when the connection with the duplex input channel was opened.
     */
    this.onConnectionOpened = function(duplexChannelEventArgs) {};

    /**
     * The event is invoked when the connection with the duplex input channel was closed.
     */
    this.onConnectionClosed = function(duplexChannelEventArgs) {};

    /**
     * The event is invoked when the response message is received.
     * This event handler method is supposed to be overridden by derived classes.
     */
    this._onResponseMessageReceived = function(duplexChannelMessageEventArgs) {};

    /**
     * Attaches the duplex output channel and opens the connection for sending request messages
     * and receiving response messages.
     * @param {WebSocketDuplexOutputChannel} outputChannel
     * @throws Throws an error message if attaching fails.
     */
    this.attachDuplexOutputChannel = function(outputChannel)
    {
        try
        {
            if (outputChannel === null)
            {
                throw "Failed to attach output channel because the output channel is null.";
            }
            if (isNullOrEmpty(outputChannel.getChannelId()))
            {
                throw "Failed to attach output channel because the channel id is null or empty string.";
            }
            if (this.isDuplexOutputChannelAttached())
            {
                throw "Failed to attach output channel because the output channel is already attached.";
            }

            myOutputChannel = outputChannel;

            // Subscribe to events.
            myOutputChannel.onConnectionOpened = this.onConnectionOpened;
            myOutputChannel.onConnectionClosed = this.onConnectionClosed;
            myOutputChannel.onResponseMessageReceived = this._onResponseMessageReceived;

            myOutputChannel.openConnection();
        }
        catch (err)
        {
            this.detachDuplexOutputChannel();
            throw err;
        }
    };

    /**
     * Detaches the duplex output channel and stops listening to response messages.
     */
    this.detachDuplexOutputChannel = function()
    {
        if (myOutputChannel !== null)
        {
            try
            {
                myOutputChannel.closeConnection();
            }
            catch (err)
            {
            }

            // Unsubscribe from events.
            myOutputChannel.onConnectionOpened = function(duplexChannelEventArgs) {};
            myOutputChannel.onConnectionClosed = function(duplexChannelEventArgs) {};
            myOutputChannel.onResponseMessageReceived = function(duplexChannelMessageEventArgs) {};

            myOutputChannel = null;
        }
    };

    /**
     * Returns true if the reference to the duplex output channel is stored.
     */
    this.isDuplexOutputChannelAttached = function()
    {
        return myOutputChannel !== null;
    };

    /**
     * Returns attached duplex output channel.
     */
    this.getAttachedDuplexOutputChannel = function()
    {
        return myOutputChannel;
    };
};

/**
 * Event arguments used to for connection related events. (e.g. onConnectionOpened, onConnectionClosed)
 * @class
 */
function DuplexChannelEventArgs(channelId, responseReceiverId)
{
    /**
     * Returns the channel id identifying the receiver of request messages. (e.g. ws://127.0.0.1:8090/).
     */
    this.ChannelId = channelId;
    
    /**
     * Returns the unique logical id identifying the receiver of response messages.
     */
    this.ResponseReceiverId = responseReceiverId;
};

/**
 * Event argument used to notify that duplex input channel received a message.
 * @class
 */
function DuplexChannelMessageEventArgs(channelId, message, responseReceiverId)
{
    /**
     * Returns the channel id identifying the receiver of request messages. (e.g. ws://127.0.0.1:8090/).
     */
    this.ChannelId = channelId;
    
    /**
     * Returns the message.
     */
    this.Message = message;
    
    /**
     * Returns the unique logical id identifying the receiver of response messages.
     */
    this.ResponseReceiverId = responseReceiverId;
};

/**
 * Duplex output channel using Websocket.
 * @class
 * @param {String} webSocketUri address of the service. (e.g. ws://127.0.0.1:8090/MyService/).
 * @param {String} responseReceiverId unique identifier of the client. If null then GUID will be generated.
 * 
 * @example
 * // Create the duplex output channel.
 * var anOutputChannel = new WebSocketDuplexOutputChannel("ws://127.0.0.1:8077/MyService/", null);
 * 
 * // Subscribe for receving messages.
 * anOutputChannel.onResponseMessageReceived = onResponseMessageReceived;
 * 
 * // Open connection.
 * anOutputChannel.openConnection();
 * 
 * ...
 * 
 * // Send a message.
 * // Note: the message can be String or byte[].
 * anOutputChannel.sendMessage("Hello World.");
 * 
 * ...
 * 
 * // Close connection when not needed.
 * anOutputChannel.closeConnection();
 * 
 * ...
 * 
 * // Your event handler to process received response messages.
 * function onResponseMessageReceived(duplexChannelMessageEventArgs) {
 *     var aMessage = duplexChannelMessageEventArgs.Message;
 *     
 *     ...
 * }
 * 
 */
function WebSocketDuplexOutputChannel(webSocketUri, responseReceiverId)
{
    // Private data members.
    var myChannelId = webSocketUri;
    var myResponseReceiverId = (responseReceiverId) ? responseReceiverId : webSocketUri + "_" + getGuid();
    var myWebSocket = null;
    var myTracedObject = "WebSocketDuplexOutputChannel " + webSocketUri + " ";

    /**
     * The event is invoked when a response message was received.
     * @param {DuplexChannelMessageEventArgs} duplexChannelMessageEventArgs
     */
    this.onResponseMessageReceived = function(duplexChannelMessageEventArgs) {};

    /**
     * The event is invoked when the connection with the duplex input channel was opened.
     * @param {DuplexChannelEventArgs} duplexChannelEventArgs
     */
    this.onConnectionOpened = function(duplexChannelEventArgs) {};

    /**
     * The event is invoked when the connection with the duplex input channel was closed.
     * @param {DuplexChannelEventArgs} duplexChannelEventArgs
     */
    this.onConnectionClosed = function(duplexChannelEventArgs) {};

    /**
     * Returns the channel id. It represents the service address.
     * @returns {String}
     */
    this.getChannelId = function()
    {
        return myChannelId;
    };

    /**
     * Returns the response receiver id. It uniquely represents this client at the service.
     * @returns {String}
     */
    this.getResponseReceiverId = function()
    {
        return myResponseReceiverId;
    };

    /**
     * Opens connection with the duplex input channel.
     * @throws Throws error message if connection could not be open.
     */
    this.openConnection = function()
    {
        if (this.isConnected())
        {
            throw "Connection is already open.";
        }

        try
        {
            myWebSocket = new WebSocket(myChannelId);

            // We want to use ArrayBuffer for data transfer.
            myWebSocket.binaryType = "arraybuffer";

            // Subscribe in WebSocket to receive notifications.
            var aSelf = this;
            myWebSocket.onopen = function(evt)
            {
                // Ask duplex input channel to open the connection.
                var anEncodedOpenConnection = encodeOpenConnectionMessage(myResponseReceiverId);
                myWebSocket.send(anEncodedOpenConnection);

                // Notify the connection is open.
                var aDuplexChannelEventArgs = new DuplexChannelEventArgs(myChannelId, myResponseReceiverId);
                aSelf.onConnectionOpened(aDuplexChannelEventArgs);
            };
            myWebSocket.onclose = function(evt)
            {
                aSelf.closeConnection();
            };
            myWebSocket.onmessage = function(evt)
            {
                // Decode incoming message.
                var aProtocolMessage = decodeMessage(evt.data);

                // Notify the message was received.
                var aDuplexChannelMessageEventArgs = new DuplexChannelMessageEventArgs(myChannelId, aProtocolMessage.Message, myResponseReceiverId);
                aSelf.onResponseMessageReceived(aDuplexChannelMessageEventArgs);
            };

            myWebSocket.onerror = function(evt)
            {
                console
                        .error(myTracedObject + "detected a WebSocket error.", evt.data);
            };
        }
        catch (err)
        {
            // Note: In case the service is not running the openConnection will
            // not fail
            // but onClose() callback will be called - this is the JavaScript
            // WebSocket object behavior.
            console.error(myTracedObject + "failed to open connection.", err);
            closeConnection();
            throw err;
        }
    };

    /**
     * Closes connection with the duplex input channel.
     */
    this.closeConnection = function()
    {
        if (myWebSocket !== null)
        {
            try
            {
                var anEncodedCloseMessage = encodeCloseConnectionMessage(myResponseReceiverId);
                myWebSocket.send(anEncodedCloseMessage);
            }
            catch (err)
            {
            }

            try
            {
                myWebSocket.close();
            }
            catch (err)
            {
            }

            myWebSocket = null;

            // Notify the connection is closed.
            var aDuplexChannelEventArgs = new DuplexChannelEventArgs(myChannelId, myResponseReceiverId);
            this.onConnectionClosed(aDuplexChannelEventArgs);
        }
    };

    /**
     * Returns true is the connection with the duplex input channel is open.
     * @returns {Boolean}
     */
    this.isConnected = function()
    {
        if (myWebSocket === null)
        {
            return false;
        }

        return true;
    };

    /**
     * Sends the message to the duplex input channel.
     * @param {String | ArrayBuffer | byte[] | Uint8Array | Int8Array} message message to be sent
     * @throws Throws error message if sending fails.
     */
    this.sendMessage = function(message)
    {
        if (this.isConnected() === false)
        {
            var anErrorMsg = myTracedObject + "failed to send the message because connection is not open.";
            console.error(anErrorMsg);
            throw anErrorMsg;
        }
        
        if (message === null)
        {
            var anErrorMsg = myTracedObject + "failed to send the message because the message was null.";
            console.error(anErrorMsg);
            throw anErrorMsg;
        }
        
        if (message.constructor !== String &&
            message.constructor !== ArrayBuffer &&
            message.constructor !== Array &&
            message.constructor !== Uint8Array &&
            message.constructor !== Int8Array)
        {
            var anErrorMsg = myTracedObject + "failed to send the message because the message is not String or byte[]";
            console.error(anErrorMsg);
            throw anErrorMsg;
        }

        try
        {
            var anEncodedMessage = encodeRequestMessage(myResponseReceiverId, message);
            myWebSocket.send(anEncodedMessage);
        }
        catch (err)
        {
            console.error(myTracedObject + "failed to send the message.", err);
            throw err;
        }
    };
};

// API: no
// Object used during decoding of messages from the duplex input channel.
function ProtocolMessage(messageType, responseReceiverId, message)
{
    this.MessageType = messageType;
    this.ResponseReceiverId = responseReceiverId;
    this.Message = message;
}

// API: no
// Constant indicating that the message coming from the duplex input channel was
// not recognized.
var constNonProtocolMessage = new ProtocolMessage("Unknonw", "", null);

// API: no
// Encodes OpenConnection message for the duplex input channel.
function encodeOpenConnectionMessage(responseReceiverId)
{
    return encodeMessage(10, responseReceiverId, null);
};

// API: no
// Encodes CloseConnection message for the duplex input channel.
function encodeCloseConnectionMessage(responseReceiverId)
{
    return encodeMessage(20, responseReceiverId, null);
};

// API: no
// Encodes RequestMessage for the duplex input channel.
function encodeRequestMessage(responseReceiverId, message)
{
    return encodeMessage(40, responseReceiverId, message);
};

// API: no
// Helper method to encode messages for the duplex input channel.
function encodeMessage(messageType, responseReceiverId, messageData)
{
    // Calculate the length of the message.
    var aLength = 6 + 3 + 4 + responseReceiverId.length * 2;
    if (messageData !== null)
    {
        if (messageData.constructor === String)
        {
            aLength = aLength + 1 + 4 + messageData.length * 2;
        }
        else
        {
            aLength = aLength + 1 + 4 + messageData.length;
        }
    }

    var aMessage = new ArrayBuffer(aLength);
    var aWriter = new DataView(aMessage);

    asciiStringToBytes(aWriter, 0, "ENETER"); // header string
    aWriter.setUint8(6, 10); // indicates little endian
    aWriter.setUint8(7, 20); // indicates UTF16
    aWriter.setUint8(8, messageType); // indicates message type

    // responseReceiverId length - true means little endian
    aWriter.setInt32(9, responseReceiverId.length * 2, true);

    utf16StringToBytes(aWriter, 13, responseReceiverId);

    if (messageData !== null)
    {
        var idx = 13 + responseReceiverId.length * 2;

        if (messageData.constructor === String)
        {
            aWriter.setUint8(idx, 20); // indicates the message is string
            aWriter.setInt32(idx + 1, messageData.length * 2, true); // length of data
            utf16StringToBytes(aWriter, idx + 1 + 4, messageData);
        }
        else if (messageData.constructor === ArrayBuffer)
        {
            aWriter.setUint8(idx, 10); // indicates the message is bytes
            aWriter.setInt32(idx + 1, messageData.length, true); // length of data

            // Copy bytes to the message.
            var aMessageDataReader = new DataView(messageData);
            var aWriteBeginIdx = idx + 1 + 4;
            for ( var i = 0; i < messageData.length; ++i)
            {
                var aValue = aMessageDataReader.getUint8(i);
                aWriter.setUint8(aWriteBeginIdx + i, aValue);
            }
        }
        else //byte[], Uint8Array, Int8Array
        {
            aWriter.setUint8(idx, 10); // indicates the message is bytes
            aWriter.setInt32(idx + 1, messageData.length, true); // length of data

            // Copy bytes to the message.
            var aWriteBeginIdx = idx + 1 + 4;
            for ( var i = 0; i < messageData.length; ++i)
            {
                var aValue = messageData[i];
                aWriter.setUint8(aWriteBeginIdx + i, aValue);
            }
        }
    }

    return aMessage;
};

// API: no
// Decodes incoming message from the duplex input channel and returns
// 'ProtocolMessage'.
function decodeMessage(message)
{
    var aReader = new DataView(message);

    // Check header. ENETER
    if (aReader.getUint8(0) !== 69 || aReader.getUint8(1) !== 78 || aReader.getUint8(2) !== 69 ||
        aReader.getUint8(3) !== 84 || aReader.getUint8(4) !== 69 || aReader.getUint8(5) !== 82)
    {

        return constNonProtocolMessage;
    }

    // Get endian encoding.
    var anEndianEncodingId = aReader.getUint8(6);
    if (anEndianEncodingId !== 10 && anEndianEncodingId !== 20)
    {

        return constNonProtocolMessage;
    }

    // Get string encoding (UTF8 or UTF16)
    var aStringEncodingId = aReader.getUint8(7);
    if (aStringEncodingId !== 10 && aStringEncodingId !== 20)
    {

        return constNonProtocolMessage;
    }

    // Get the message type.
    var aMessageType = aReader.getUint8(8);

    // If it is response message.
    if (aMessageType === 40)
    {

        // Get response receiver id.
        // Note: the second parameter is true if the length is in little-endian
        // encoded.
        var aSize = aReader.getInt32(9, anEndianEncodingId === 10);

        // Note: we can ignore the response receicer id on the client.
        // Note: the size of respopnse receiver id should be 0 here on the
        // client side.

        // Get message serialization type (string or byte[]).
        var aSerializationType = aReader.getUint8(9 + 4 + aSize);

        // Get the message data size.
        var aMessageDataSize = aReader
                .getInt32(9 + 4 + aSize + 1, anEndianEncodingId === 10);

        var aDataMessageIdx = 9 + 4 + aSize + 1 + 4;

        // If bytes.
        if (aSerializationType === 10)
        {
            var aBytes = message
                    .slice(aDataMessageIdx, aDataMessageIdx + aMessageDataSize);
            var aProtocolMessage = new ProtocolMessage("MessageReceived", "", aBytes);

            return aProtocolMessage;
        }

        // If string.
        if (aSerializationType === 20)
        {
            var aStr = "";

            // If the incoming string is UTF-8.
            if (aStringEncodingId === 10) aStr = utf8BytesToUtf16String(aReader, aDataMessageIdx, aMessageDataSize);
				
            else if (aStringEncodingId === 20)
            {
                for ( var i = 0; i < aMessageDataSize; ++i)
					aStr += String.fromCharCode(aReader.getUint8(aDataMessageIdx + i));
            }

            var aProtocolMessage = new ProtocolMessage("MessageReceived", "", aStr.replace(/\0/g, ''));
            return aProtocolMessage;
        }
    }

    return constNonProtocolMessage;
}

// API: no
// Helper method converting string to bytes in UTF-16 unicode format.
function utf16StringToBytes(dataView, beginIdx, str)
{
    var ch;
    for ( var i = 0; i < str.length; ++i)
    {
        ch = str.charCodeAt(i);
        dataView.setUint16(beginIdx + i * 2, ch, true); // true means
                                                        // little-endian
    }
};

// API: no
// Helper method converting string to bytes in ASCII code format.
function asciiStringToBytes(dataView, beginIdx, str)
{
    var ch;
    for ( var i = 0; i < str.length; ++i)
    {
        ch = str.charCodeAt(i);
        dataView.setUint8(beginIdx + i, ch);
    }
};

// API: no
// Helper method reading UTF-8 bytes into UTF-16 string.
function utf8BytesToUtf16String(reader, beginIdx, size)
{
    var aResult = "";
    var aCode;
    var i;
    var aValue;
    for (i = 0; i < size; i++)
    {

        aValue = reader.getUint8(beginIdx + i);

        // If one byte character.
        if (aValue <= 0x7f)
        {
            aResult += String.fromCharCode(aValue);
        }
        // If mutlibyte character.
        else if (aValue >= 0xc0)
        {
            // 2 bytes.
            if (aValue < 0xe0)
            {
                aCode = ((reader.getUint8(beginIdx + i++) & 0x1f) << 6) | (reader
                        .getUint8(beginIdx + i) & 0x3f);
            }
            // 3 bytes.
            else if (aValue < 0xf0)
            {
                aCode = ((reader.getUint8(beginIdx + i++) & 0x0f) << 12) | ((reader
                        .getUint8(beginIdx + i++) & 0x3f) << 6) | (reader
                        .getUint8(beginIdx + i) & 0x3f);
            }
            // 4 bytes.
            else
            {
                // turned into two characters in JS as surrogate pair
                aCode = (((reader.getUint8(beginIdx + i++) & 0x07) << 18) | ((reader
                        .getUint8(beginIdx + i++) & 0x3f) << 12) | ((reader
                        .getUint8(beginIdx + i++) & 0x3f) << 6) | (reader
                        .getUint8(beginIdx + i) & 0x3f)) - 0x10000;
                // High surrogate
                aResult += String
                        .fromCharCode(((aCode & 0xffc00) >>> 10) + 0xd800);
                // Low surrogate
                aCode = (aCode & 0x3ff) + 0xdc00;
            }
            aResult += String.fromCharCode(aCode);
        } // Otherwise it's an invalid UTF-8, skipped.
    }
    return aResult;
};

// API: no
// Helper method creating GUID.
function getGuid()
{
    var aGuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
            .replace(/[xy]/g, function(c)
            {
                var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });

    return aGuid;
};

// API: no
// Helper method to check if a string is null or empty.
function isNullOrEmpty(stringValue)
{
    return stringValue === null || stringValue === "";
};

