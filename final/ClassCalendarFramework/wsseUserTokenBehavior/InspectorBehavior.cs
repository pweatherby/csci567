//http://isyourcode.blogspot.com/2010/08/attaching-oasis-username-tokens-headers.html
using System;
using System.ServiceModel.Channels;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;

namespace wsseUserTokenBehavior
{
    public class InspectorBehavior : IEndpointBehavior
    {
        public ClientInspector ClientInspector { get; set; }
        public InspectorBehavior(ClientInspector clientInspector)
        {
            ClientInspector = clientInspector;
        }
        public void Validate(ServiceEndpoint endpoint)
        { }
        public void AddBindingParameters(ServiceEndpoint endpoint, BindingParameterCollection bindingParameters)
        {
        }
        public void ApplyDispatchBehavior(ServiceEndpoint endpoint, EndpointDispatcher endpointDispatcher)
        { }
        public void ApplyClientBehavior(ServiceEndpoint endpoint, ClientRuntime clientRuntime)
        {
            if (this.ClientInspector == null) throw new InvalidOperationException("Caller must supply ClientInspector.");
            clientRuntime.MessageInspectors.Add(ClientInspector);
        }
    }
}
