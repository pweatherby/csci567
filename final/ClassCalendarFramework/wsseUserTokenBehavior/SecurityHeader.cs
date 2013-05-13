//http://isyourcode.blogspot.com/2010/08/attaching-oasis-username-tokens-headers.html
using System;
using System.Security.Cryptography;
using System.ServiceModel.Channels;
using System.Text;
using System.Xml;

namespace wsseUserTokenBehavior
{
    public class SecurityHeader : MessageHeader
    {
        public enum PasswordType
        {
            Unknown = 0,
            Digest = 1,
            ClearText = 2,
        }

        public string SystemUser { get; set; }
        public string SystemPassword { get; set; }
        public PasswordType SystermPasswordType { get; set; }
        public SecurityHeader(string systemUser, string systemPassword, PasswordType systemPasswordType = PasswordType.ClearText)
        {
            this.SystemUser = systemUser;
            this.SystemPassword = systemPassword;
            this.SystermPasswordType = systemPasswordType;
        }
        public override string Name
        {
            get { return "wsse:Security"; }
        }

        public override string Namespace
        {
            get { return String.Empty; }// "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"; }
        }

        public override bool MustUnderstand
        {
            get
            {
                return true;
            }
        }
        protected override void OnWriteHeaderContents(XmlDictionaryWriter writer, MessageVersion messageVersion)
        {
            WriteHeader(writer);
        }
        private void WriteHeader(XmlDictionaryWriter writer)
        {

            //Begin Variable setups
            var nonce = new byte[64];
            RandomNumberGenerator.Create().GetBytes(nonce);
            string created = DateTime.Now.ToString("yyyy-MM-ddThh:mm:ss.msZ");
            //End Variable setups

            // Write Namespace attributes on the "wsse:Security" Node
            writer.WriteXmlnsAttribute("wsse", "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd");
            writer.WriteXmlnsAttribute("wsu", "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd");
            
            // Begin UsernameToken Holder for UserName, Password, Nonce, and Created Nodes
            writer.WriteStartElement("wsse", "UsernameToken", null);
            writer.WriteAttributeString("wsu", "Id", null, "UsernameToken-2");
            
            //Begin Username
            writer.WriteStartElement("wsse", "Username", null);
            writer.WriteString(SystemUser);
            writer.WriteEndElement();
            //End Username 
            //Begin Password Plaintext
            writer.WriteStartElement("wsse", "Password", null);
            if (this.SystermPasswordType == PasswordType.ClearText)
            {
                writer.WriteAttributeString("Type", "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText");
                writer.WriteString(SystemPassword);
            }
            else if (this.SystermPasswordType == PasswordType.Digest)
            {
                writer.WriteAttributeString("Type", "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordDigest");
                writer.WriteString(ComputePasswordDigest(SystemPassword, nonce, created));
            }
            writer.WriteEndElement();
            //End Password Plaintext

            //Begin Password Nonce
            writer.WriteStartElement("wsse", "Nonce", null);
            writer.WriteAttributeString("EncodingType", "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary");
            writer.WriteBase64(nonce, 0, nonce.Length);
            writer.WriteEndElement();
            //End Password Nonce 

            //Begin Created
            writer.WriteStartElement("wsu", "Created", null);
            writer.WriteString(created);
            writer.WriteEndElement();
            //End Created 

            writer.WriteEndElement();
            // Begin UsernameToken Holder

            writer.Flush();
        }
        private string ComputePasswordDigest(string secret, byte[] nonceInBytes, string created)
        {
            byte[] createdInBytes = Encoding.UTF8.GetBytes(created);
            byte[] secretInBytes = Encoding.UTF8.GetBytes(secret);
            byte[] concatenation = new byte[nonceInBytes.Length + createdInBytes.Length + secretInBytes.Length];
            Array.Copy(nonceInBytes, concatenation, nonceInBytes.Length);
            Array.Copy(createdInBytes, 0, concatenation, nonceInBytes.Length, createdInBytes.Length);
            Array.Copy(secretInBytes, 0, concatenation, (nonceInBytes.Length + createdInBytes.Length), secretInBytes.Length);
            return Convert.ToBase64String(SHA1.Create().ComputeHash(concatenation));
        }
    }
}
