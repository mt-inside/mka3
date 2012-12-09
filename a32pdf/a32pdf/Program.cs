using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using OpenQA.Selenium.Firefox;

namespace a32pdf
{
    class Program
    {
        static void Main(string[] args)
        {
            //hack
            DoIt(@"C:/Users/user/Documents/GitHub/mka3");
            return;

            if (args.Length != 1)
            {
                Console.WriteLine("Usage: a32pdf path");
                return;
            }

            DoIt(args[0]);
        }

        static void DoIt(string path)
        {
            string uri = @"file:///" + path;

            var d = new FirefoxDriver();
            d.Manage().Window.Size = new Size(2000, 2000);
            d.Navigate().GoToUrl(Path.Combine(uri, "a3.html"));

            var s = d.GetScreenshot();
            s.SaveAsFile(Path.Combine(path, "a3.png"), ImageFormat.Png);

            d.Quit();
        }
    }
}