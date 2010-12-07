using System;
using System.Diagnostics.Contracts;
using System.IO;
using NHibernate.Cfg;
using NHibernate.Tool.hbm2ddl;

namespace Trinity.Encore.Framework.Persistence.Schema
{
    public sealed class SchemaInfo
    {
        private readonly SchemaExport _schema;

        [ContractInvariantMethod]
        private void Invariant()
        {
            Contract.Invariant(_schema != null);
        }

        public SchemaInfo(DatabaseContext ctx)
        {
            Contract.Requires(ctx != null);

            _schema = new SchemaExport(ctx.Configuration);
        }

        public void Create()
        {
            _schema.Create(false, true);
        }

        public void Drop()
        {
            _schema.Drop(false, true);
        }

        public void Export(string file)
        {
            Contract.Requires(!string.IsNullOrEmpty(file));

            var oldOut = Console.Out;
            Console.SetOut(TextWriter.Null); // HACK: How do we make NHibernate not throw the SQL to the console?

            _schema.SetOutputFile(file);
            _schema.Create(true, false);

            Console.SetOut(oldOut);
        }
    }
}
