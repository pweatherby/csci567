using System;
using System.Net;

namespace SvcTester
{
    class Program
    {
        static void Main(string[] args)
        {
            //TestTerms();
            //TestSessions();
            TestCart();
            Console.ReadLine();
        }

        private static void TestDLL()
        {
            noble.coder.pweatherby.AppValet.ValetKeyStatus stats = noble.coder.pweatherby.AppValet.ValetStand.GetKeyStatus("89b25df7-560f-4e6a-8cbc-097ea9a689c7", "fe22036a-8c47-458e-9302-48ce6cc920a6");
           Console.WriteLine(Enum.GetName(typeof(noble.coder.pweatherby.AppValet.ValetKeyStatus), stats));
        }

        private static void TestTerms()
        {
            using (WebClient wc = new WebClient())
            {
                //if auth needed;
                //wc.UseDefaultCredentials = false;
                //wc.Credentials = new NetworkCredential("89b25df7-560f-4e6a-8cbc-097ea9a689c7", "fe22036a-8c47-458e-9302-48ce6cc920a6");
                String response = wc.DownloadString("https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/TERMS_REQUEST.ashx");
                Console.WriteLine(response);
                Console.WriteLine("-----------------------------------------");
                Console.WriteLine("-----------------------------------------");
            }
        }

        private static void TestSessions()
        {
            using (WebClient wc = new WebClient())
            {
                //if auth needed;
                //wc.UseDefaultCredentials = false;
                //wc.Credentials = new NetworkCredential("89b25df7-560f-4e6a-8cbc-097ea9a689c7", "fe22036a-8c47-458e-9302-48ce6cc920a6");
                String response = wc.DownloadString("https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/SESSIONS_REQUEST.ashx?term=2138");
                Console.WriteLine(response);
                Console.WriteLine("-----------------------------------------");
                Console.WriteLine("-----------------------------------------");
            }
        }

        private static void TestSubjects()
        {
            using (WebClient wc = new WebClient())
            {
                //if auth needed;
                //wc.UseDefaultCredentials = false;
                //wc.Credentials = new NetworkCredential("89b25df7-560f-4e6a-8cbc-097ea9a689c7", "fe22036a-8c47-458e-9302-48ce6cc920a6");
                String response = wc.DownloadString("https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/SUBJECTS_REQUEST.ashx?term=2138");
                Console.WriteLine(response);
                Console.WriteLine("-----------------------------------------");
                Console.WriteLine("-----------------------------------------");
            }
        }

        private static void TestCart()
        {
            using (WebClient wc = new WebClient())
            {
                //if auth needed;
                wc.UseDefaultCredentials = false;
                wc.Credentials = new NetworkCredential("89b25df7-560f-4e6a-8cbc-097ea9a689c7", "cfc2d4ed-59fd-4163-9f1a-0df9cff0cace");
                String response = wc.DownloadString("https://emsdev.csuchico.edu/services/ClassSchedule/ShopCart/JSON/ViewCart.ashx");
                Console.WriteLine(response);
                Console.WriteLine("-----------------------------------------");
                Console.WriteLine("-----------------------------------------");
            }
        }
    }
}
