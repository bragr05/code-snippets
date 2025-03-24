let parameters = {};

parameters.idt_cobtDocumento = 1;
parameters.idGestion = 999;

fetch('@Url.Action("DescargarArchivo", "Parameters")', {
    method: "POST",
    body: JSON.stringify(parameters),
    headers: {
        "Content-Type": "application/json",
    },
})
    .then((response) => {
        if (response.status === 200) {
            const fileName =
                response.headers
                    .get("Content-Disposition")
                    ?.split("filename=")[1] || "archivo.pdf";
            return response.blob().then((blob) => ({ blob, fileName }));
        } else if (response.status === 202) {
            throw new Error(response.headers.get("ErrorMessage"));
        } else {
            throw new Error("Error al descargar el archivo");
        }
    })
    .then(({ blob, fileName }) => {
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement("a");

        link.href = url;
        link.download = fileName;
        document.body.appendChild(link);
        link.click();

        window.URL.revokeObjectURL(url);
        document.body.removeChild(link);
    })
    .catch((error) => {
        console.error(error.message);
    });
