using Xunit;
using BolivianosEnBarcelona.Models;

namespace BolivianosEnBarcelona.Tests
{
    public class BusinessTests
    {
        [Fact]
        public void PrepararBusqueda_DebeNormalizarTextosCorrectamente()
        {
            // 1. Preparar
            var negocio = new Business
            {
                Name = "El Rincón Del Café",
                Description = "¡Comida, música y más!",
                Category = "Gastronomía"
            };

            // 2. Ejecutar
            negocio.PrepararBusqueda();

            // 3. Verificar
            Assert.Equal("el rincon del cafe", negocio.NormalizedName);
            Assert.Equal("¡comida, musica y mas!", negocio.NormalizedDescription);
            Assert.Equal("gastronomia", negocio.NormalizedCategory);
        }

        [Fact]
        public void WhatsAppLink_DebeGenerarEnlaceLimpio()
        {
            var negocio = new Business { PhoneNumber = "+34 600 123 456" };
            // Verifica que quita el + y los espacios
            Assert.Equal("https://wa.me/34600123456", negocio.WhatsAppLink);
        }
    }
}