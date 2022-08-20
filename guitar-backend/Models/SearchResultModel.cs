namespace guitar_backend.ActionModels
{
    public class SearchResultModel
    {
        public IEnumerable<Product> Products { get; set; } = null!;
        public int Found { get; set; }
    }
}
