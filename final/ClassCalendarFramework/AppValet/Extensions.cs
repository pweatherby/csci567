using System;

namespace noble.coder.pweatherby.AppValet
{
    public static class Extensions
    {
        public static String ToString(this ValetKeyStatus sts)
        {
            switch (sts)
            {
                case ValetKeyStatus.Active:
                    return "A";
                case ValetKeyStatus.Inactive:
                    return "I";
                case ValetKeyStatus.Blocked:
                    return "B";
            }
            return String.Empty;
        }
        public static ValetKeyStatus ToValetKeyStatus(this Object obj)
        {
            if (obj is ValetKeyStatus)
            {
                return obj as ValetKeyStatus? ?? ValetKeyStatus.Unknown;
            }
            if (obj is String || obj is Char)
            {
                String sts = Convert.ToString(obj).Trim();
                if (sts.Equals("A", StringComparison.InvariantCultureIgnoreCase))
                {
                    return ValetKeyStatus.Active;
                }
                if (sts.Equals("I", StringComparison.InvariantCultureIgnoreCase))
                {
                    return ValetKeyStatus.Inactive;
                }
                if (sts.Equals("B", StringComparison.InvariantCultureIgnoreCase))
                {
                    return ValetKeyStatus.Blocked;
                }
            }
            String name = Enum.GetName(typeof(ValetKeyStatus), obj);
            if (!String.IsNullOrWhiteSpace(name))
            {
                ValetKeyStatus s = ValetKeyStatus.Unknown;
                if (Enum.TryParse<ValetKeyStatus>(name, out s))
                {
                    return s;
                }
            }
            return ValetKeyStatus.Unknown;
        }
    }
}
